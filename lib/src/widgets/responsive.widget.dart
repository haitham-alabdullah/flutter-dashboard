import 'package:flutter/material.dart';

import '../classes/enums.class.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  ScreenSize screen,
);

class ScreenSize {
  final double width;
  ScreenSize(this.width);

  bool get is4K => width > 1900;
  bool get isDesktop => width > 1024;
  bool get isTablet => width > 500 && !isDesktop;
  bool get isMobile => !isTablet && !isDesktop;
  ScreenSizeType get screenType => calculateScreenType();

  ScreenSizeType calculateScreenType() {
    if (isDesktop) return ScreenSizeType.desktop;
    if (isTablet) return ScreenSizeType.tablet;
    return ScreenSizeType.mobile;
  }

  int gridAxis() {
    if (is4K) return 12;
    if (isDesktop) return 9;
    if (isTablet) return 6;
    return 3;
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
