import 'package:crypto_concept/src/core/presentation/generated/fonts.gen.dart';
import 'package:flutter/material.dart';

/// light/dark theme 및 폰트를 정의한 class
class AppTheme {
  const AppTheme();

  static const double kFontBodySize = 20.0;
  static const double kGoldenRatio = 1.618;

  /// !Note: math library 안의 pow 를 사용하려 했으나, 그럴시
  ///
  /// 1. build time constant 가 아니게 되고
  /// 2. 수가 여러번 곱해지지 않아 지금 가독성도 괜찮기
  ///
  /// 때문에 manual로 계산함
  static const double kFontDisplaySize =
      kFontBodySize * kGoldenRatio * kGoldenRatio * kGoldenRatio;
  static const double kFontHeaderSize =
      kFontBodySize * kGoldenRatio * kGoldenRatio;
  static const double kFontTitleSize = kFontBodySize * kGoldenRatio;
  static const double kFontLabelSize = kFontBodySize * 1.16;

  static const _light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF005AC3),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD8E2FF),
    onPrimaryContainer: Color(0xFF001A42),
    secondary: Color(0xFF4459A9),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFDDE1FF),
    onSecondaryContainer: Color(0xFF001452),
    tertiary: Color(0xFF00658B),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC5E7FF),
    onTertiaryContainer: Color(0xFF001E2D),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFEFBFF),
    onBackground: Color(0xFF1B1B1F),
    surface: Color(0xFFFEFBFF),
    onSurface: Color(0xFF1B1B1F),
    surfaceVariant: Color(0xFFE1E2EC),
    onSurfaceVariant: Color(0xFF44474F),
    outline: Color(0xFF75777F),
    onInverseSurface: Color(0xFFF2F0F4),
    inverseSurface: Color(0xFF303034),
    inversePrimary: Color(0xFFAEC6FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF005AC3),
    outlineVariant: Color(0xFFC5C6D0),
    scrim: Color(0xFF000000),
  );

  static const _dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFAEC6FF),
    onPrimary: Color(0xFF002E6A),
    primaryContainer: Color(0xFF004395),
    onPrimaryContainer: Color(0xFFD8E2FF),
    secondary: Color(0xFFB7C4FF),
    onSecondary: Color(0xFF0D2878),
    secondaryContainer: Color(0xFF2A4190),
    onSecondaryContainer: Color(0xFFDDE1FF),
    tertiary: Color(0xFF7ED0FF),
    onTertiary: Color(0xFF00344A),
    tertiaryContainer: Color(0xFF004C6A),
    onTertiaryContainer: Color(0xFFC5E7FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF000000),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1B1B1F),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF44474F),
    onSurfaceVariant: Color(0xFFC5C6D0),
    outline: Color(0xFF8E9099),
    onInverseSurface: Color(0xFF1B1B1F),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF005AC3),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFAEC6FF),
    outlineVariant: Color(0xFF44474F),
    scrim: Color(0xFF000000),
  );

  static ThemeData get light {
    final rawThemeData = ThemeData(
      useMaterial3: true,
      colorScheme: _light,
      fontFamily: FontFamily.gMarketSans,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
    );

    return _newThemeWithTextStyle(rawThemeData);
  }

  static ThemeData get dark {
    final rawThemeData = ThemeData(
      useMaterial3: true,
      colorScheme: _dark,
      fontFamily: FontFamily.gMarketSans,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
    );

    return _newThemeWithTextStyle(rawThemeData);
  }

  static ThemeData _newThemeWithTextStyle(ThemeData original) {
    // 대부분의 경우 `DisplayMedium', `HeadlineMedium`, `BodyMedium`
    // 총 3개로만  hierarchy 를 표현할 것임
    return original.copyWith(
      textTheme: original.textTheme.copyWith(
        displayLarge: original.textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1.1,
          height: 1.15,
          fontSize: 1.1 * kFontDisplaySize,
          color: original.textTheme.displayLarge?.color,
        ),
        displayMedium: original.textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1.1,
          height: 1.18,
          fontSize: kFontDisplaySize,
          color: original.textTheme.displayMedium?.color,
        ),
        displaySmall: original.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
          height: 1.2,
          fontSize: 0.9 * kFontDisplaySize,
          color: original.textTheme.displaySmall?.color,
        ),
        headlineLarge: original.textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -1.0,
          height: 1.2,
          fontSize: 1.1 * kFontHeaderSize,
        ),
        headlineMedium: original.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -1.0,
          height: 1.2,
          fontSize: kFontHeaderSize,
        ),
        headlineSmall: original.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          height: 1.2,
          fontSize: 0.9 * kFontHeaderSize,
        ),
        titleLarge: original.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 1.1 * kFontTitleSize,
          height: 1.2,
        ),
        titleMedium: original.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w400,
          letterSpacing: -0.3,
          fontSize: kFontTitleSize,
          height: 1.2,
        ),
        titleSmall: original.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
          letterSpacing: -0.3,
          fontSize: 0.9 * kFontTitleSize,
          height: 1.2,
        ),
        bodyLarge: original.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w200,
          fontSize: 1.1 * kFontBodySize,
        ),
        bodyMedium: original.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w200,
          fontSize: kFontBodySize,
        ),
        bodySmall: original.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w200,
          fontSize: 0.9 * kFontBodySize,
        ),
        labelLarge: original.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 1.1 * kFontLabelSize,
        ),
        labelMedium: original.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: kFontLabelSize,
        ),
        labelSmall: original.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 0.9 * kFontLabelSize,
        ),
      ),
    );
  }
}
