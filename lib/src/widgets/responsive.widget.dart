import 'package:flutter/material.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  Widget child,
);

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    this.desktop,
    this.tablet,
    this.mobile,
    super.key,
  });

  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024 && desktop is Widget) return desktop!;
        if (constraints.maxWidth > 480 && tablet is Widget) return tablet!;
        return mobile ?? const SizedBox();
      },
    );
  }
}
