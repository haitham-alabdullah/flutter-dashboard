import 'package:flutter/material.dart';

class DashboardCardModel {
  final String name;
  final IconData icon;
  final int value;
  final double persentage;
  final String persentageValue;
  final String notes;

  DashboardCardModel({
    required this.name,
    required this.icon,
    required this.value,
    required this.persentage,
    required this.persentageValue,
    required this.notes,
  });

  factory DashboardCardModel.fromJson(json) {
    return DashboardCardModel(
      name: json['name'],
      icon: json['icon'],
      value: json['value'],
      persentage: json['persentage'],
      persentageValue: json['persentageValue'],
      notes: json['notes'],
    );
  }
}
