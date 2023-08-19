import 'package:dashboard/src/classes/constents.class.dart';
import 'package:flutter/material.dart';

class NavBarButtonWidget extends StatelessWidget {
  const NavBarButtonWidget({
    required this.desktop,
    required this.onTap,
    required this.icon,
    required this.text,
    super.key,
  });

  final bool desktop;
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: desktop
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon),
              label: Text(text),
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            )
          : SizedBox(
              width: 45,
              child: Tooltip(
                message: text,
                child: IconButton.filled(
                  onPressed: onTap,
                  icon: Icon(icon),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    shadowColor: Colors.black26,
                    elevation: 5,
                    shape: const CircleBorder(),
                    // shape: const ContinuousRectangleBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // ),
                  ),
                ),
              ),
            ),
    );
  }
}
