import 'dart:ui';

import 'package:crypto_concept/src/core/presentation/ui/game_intro_screen.dart';
import 'package:crypto_concept/src/core/presentation/ui/layout_constant.dart';
import 'package:crypto_concept/src/core/presentation/ui/outro_screen.dart';
import 'package:crypto_concept/src/core/presentation/ui/product_intro_screen.dart';
import 'package:crypto_concept/src/core/presentation/ui/shader_screen.dart';
import 'package:crypto_concept/src/core/presentation/ui/intro_screen.dart';
import 'package:flutter/material.dart';

/// 화면에 보여지게 될 페이지 들의 부모 Widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;
  late ValueNotifier<int> _pageNotifier;

  /// 같이 묶어서 사용할 Widget 쌍. class 를 만들기보다 record 를 사용
  final List<({Widget backgroundScreen, Widget foregroundScreen})> _pages = [];

  @override
  void initState() {
    super.initState();
    _pageNotifier = ValueNotifier(0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    Future.delayed(
      const Duration(seconds: 2),
      () => _animationController.forward(),
    );
    _pageController = PageController()
      ..addListener(() {
        final page = (_pageController.page ?? 0.0).round();
        if (_pageNotifier.value != page) {
          _pageNotifier.value = page;
        }
      });
    _loadShaders();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadShaders() async {
    final moonShaderProgram = await FragmentProgram.fromAsset(
        'assets/shaders/atmospheric_scattering.frag');
    final gameShaderProgram = await FragmentProgram.fromAsset(
        'assets/shaders/spherical_polyhedra.frag');
    final glowingShaderProgram =
        await FragmentProgram.fromAsset('assets/shaders/neon_lines.frag');
    final bubbleShaderProgram =
        await FragmentProgram.fromAsset('assets/shaders/bubble_ring.frag');

    _pages.add((
      backgroundScreen: ForwardingShaderScreen(
        shaderProgram: moonShaderProgram,
        animation: _animationController,
      ),
      foregroundScreen: IntroScreen(
        key: const ValueKey('intro'),
        animation: _animationController,
      )
    ));
    _pages.add((
      backgroundScreen: RepeatingShaderScreen(
          key: const ValueKey('product'), shaderProgram: bubbleShaderProgram),
      foregroundScreen: const ProductIntroScreen(
        key: ValueKey('product'),
      ),
    ));
    _pages.add((
      backgroundScreen: RepeatingShaderScreen(
          key: const ValueKey('game'), shaderProgram: gameShaderProgram),
      foregroundScreen: const GameIntroScreen(
        key: ValueKey('game'),
      ),
    ));
    _pages.add((
      backgroundScreen: RepeatingShaderScreen(
          key: const ValueKey('outro'), shaderProgram: glowingShaderProgram),
      foregroundScreen: const OutroScreen(
        key: ValueKey('outro'),
      ),
    ));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Shader Backgrounder
              ValueListenableBuilder<int>(
                valueListenable: _pageNotifier,
                builder: (context, value, child) {
                  if (_pages.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                    alignment:
                        _shaderAlignmentByConstraints(constraints, value == 0),
                    child: _pages[value].backgroundScreen,
                  );
                },
              ),
              // Text Contents
              Positioned.fill(
                child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder(
                      valueListenable: _pageNotifier,
                      builder: (context, value, child) {
                        return AnimatedOpacity(
                          duration: Duration(
                            milliseconds: value == index ? 800 : 100,
                          ),
                          opacity: value == index ? 1 : 0,
                          curve: Curves.ease,
                          child: _pages[index].foregroundScreen,
                        );
                      },
                    );
                  },
                  itemCount: _pages.length,
                  scrollDirection: Axis.vertical,
                ),
              ),
              // Page Indexing for touch
              PageIndexer(
                indexNotifier: _pageNotifier,
                length: _pages.length,
                onTap: (index) => _pageController.jumpToPage(index),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.03),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.4, 0.6, curve: Curves.ease),
                      ),
                    ),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.4,
                          0.6,
                          curve: Curves.easeOut,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
                child: ValueListenableBuilder(
                  valueListenable: _pageNotifier,
                  builder: (context, value, child) {
                    return AnimatedAlign(
                      duration: const Duration(milliseconds: 400),
                      alignment:
                          _titleAlignmentByConstraints(constraints, value == 0),
                      curve: Curves.ease,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 400),
                        style: value == 0
                            ? Theme.of(context).textTheme.headlineMedium!
                            : Theme.of(context).textTheme.labelMedium!,
                        curve: Curves.ease,
                        child: const Text(
                          'n.portverse',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Alignment _shaderAlignmentByConstraints(
      BoxConstraints constraints, bool isInitialPage) {
    return valueByScreenSize(
      constraints,
      mobile:
          isInitialPage ? const Alignment(0, -0.3) : const Alignment(0, -0.6),
      tablet:
          isInitialPage ? const Alignment(0, -0.1) : const Alignment(0, -0.3),
      desktop: isInitialPage ? Alignment.center : const Alignment(-0.8, 0),
    );
  }

  Alignment _titleAlignmentByConstraints(
      BoxConstraints constraints, bool isInitialPage) {
    return valueByScreenSize(
      constraints,
      mobile: isInitialPage
          ? const Alignment(0, -0.85)
          : const Alignment(-0.9, -0.9),
      tablet: isInitialPage
          ? const Alignment(0, -0.8)
          : const Alignment(-0.9, -0.9),
      desktop: isInitialPage
          ? const Alignment(0, -0.7)
          : const Alignment(-0.9, -0.9),
    );
  }
}

class PageIndexer extends StatelessWidget {
  const PageIndexer({
    super.key,
    required ValueNotifier<int> indexNotifier,
    required int length,
    required ValueChanged<int> onTap,
  })  : _pageNotifier = indexNotifier,
        _length = length,
        _onTap = onTap;

  final ValueNotifier<int> _pageNotifier;
  final int _length;
  final ValueChanged<int> _onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 30.0,
      child: Align(
        alignment: Alignment.centerRight,
        child: ValueListenableBuilder<int>(
          valueListenable: _pageNotifier,
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                _length,
                (index) => GestureDetector(
                  onTap: () => _onTap.call(index),
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: value == index ? FontWeight.bold : null,
                          ),
                      child: Text(
                        '${index + 1}',
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
