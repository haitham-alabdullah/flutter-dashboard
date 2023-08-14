import 'package:flutter/material.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  ScreenSize screen,
);

enum ScreenSizeType { desktop, tablet, mobile }

class ScreenSize {
  final double width;
  ScreenSize(this.width);

  bool get isDesktop => width > 1024;
  bool get isTablet => width > 480 && !isDesktop;
  bool get isMobile => !isTablet && !isDesktop;
  ScreenSizeType get screenType => calculateScreenType();

  ScreenSizeType calculateScreenType() {
    if (isDesktop) return ScreenSizeType.desktop;
    if (isTablet) return ScreenSizeType.tablet;
    return ScreenSizeType.mobile;
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
