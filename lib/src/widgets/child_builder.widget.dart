import 'package:flutter/material.dart';

typedef WidgetChildBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

class ChildBuilder extends StatelessWidget {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const ChildBuilder({
    super.key,
    required this.builder,
    required this.child,
  });

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final WidgetChildBuilder builder;
  final Widget child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}
