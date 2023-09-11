import 'package:flutter/material.dart';

import '../../classes/enums.class.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  ScreenSize screen,
);

class ScreenSize {
  final double width;
  ScreenSize(this.width);

  bool get is4K => width > 1600;
  bool get isDesktop => width > 1024 && !is4K;
  bool get isTablet => width > 768 && !isDesktop;
  bool get isMobile => !isTablet && !isDesktop && !is4K;
  bool get isSmall => isMobile || isTablet;
  bool get isBig => isDesktop || is4K;
  ScreenSizeType get screenType => calculateScreenType();

  ScreenSizeType calculateScreenType() {
    if (isDesktop) return ScreenSizeType.desktop;
    if (isTablet) return ScreenSizeType.tablet;
    return ScreenSizeType.mobile;
  }

  int gridAxis() {
    if (is4K) return 24;
    if (isDesktop) return 18;
    if (isTablet) return 12;
    return 6;
  }

  int setAxis(int? xl, int? lg, int? md, int? sm) {
    xl ??= 24;
    if (is4K) return xl;
    if (isDesktop) return lg ?? xl;
    if (isTablet) return md ?? lg ?? xl;
    return sm ?? md ?? lg ?? xl;
  }
}

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    required this.builder,
    super.key,
  });

  final ResponsiveBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenSize size = ScreenSize(constraints.maxWidth);
        return builder(context, size);
      },
    );
  }
}
