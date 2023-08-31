import 'package:flutter/material.dart';

import '../classes/functions.class.dart';

class MenuList extends StatelessWidget {
  const MenuList({
    required this.builder,
    required this.actions,
    this.offset,
    super.key,
  });

  final Widget Function(MenuController) builder;
  final List<Widget> actions;
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: offset ?? const Offset(0, 15),
      menuChildren: actions,
      builder: (_, controller, __) => builder(controller),
      style: MenuStyle(
        shape: MaterialStateProperty.all(
          const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        alignment: Alignment.bottomLeft,
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    required this.title,
    required this.svgName,
    this.width = 200,
    this.callback,
    this.color,
    super.key,
  });

  final double width;
  final VoidCallback? callback;
  final String title;
  final String svgName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MenuItemButton(
        style: MenuItemButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        requestFocusOnHover: false,
        onPressed: callback,
        trailingIcon: svg(svgName, size: 16, color: color ?? Colors.blueGrey),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: color ?? Colors.blueGrey.shade900),
        ),
      ),
    );
  }
}
