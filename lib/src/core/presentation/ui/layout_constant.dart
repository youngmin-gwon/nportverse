import 'package:flutter/material.dart';

/// 공통으로 사용하는 상수 모아놓은 클래스
class LayoutConstant {
  const LayoutConstant._();

  static const mobileBreakPoint = 480;
  static const tabletBreakPoint = 820;
}

T valueByScreenSize<T>(BoxConstraints constraints,
    {required T mobile, required T tablet, required T desktop}) {
  if (constraints.maxWidth <= LayoutConstant.mobileBreakPoint) {
    return mobile;
  } else if (constraints.maxWidth <= LayoutConstant.tabletBreakPoint) {
    return tablet;
  } else {
    return desktop;
  }
}
