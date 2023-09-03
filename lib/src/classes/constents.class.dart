import 'package:flutter/material.dart';

const Color primaryColor = Colors.blueAccent;

const Color navbarColor = Colors.white;
const Color drawerColor = Colors.white;

const bool toastAutoDissmiss = true;
const Duration toastDuration = Duration(milliseconds: 200);
const Duration toastDissmissDuration = Duration(seconds: 4);

// this is the maximum width the main container can take as width => in web called (fixed, fluid)
// it can be double.infinity or fixed double like 1600.0
const double maxContainerWidth = 1600;

// if true a BreadCampWidget will be showen at the top of the main container
// you can add or edit this widget as you like, you will find it in the /src/widgets/app_widgets.
const bool showBreadCamp = false;

const List<BoxShadow> cardShadow = [
  BoxShadow(
    color: Color(0x1F6E9AE6),
    offset: Offset(0, 12),
    blurRadius: 20,
    spreadRadius: .05,
  ),
];
