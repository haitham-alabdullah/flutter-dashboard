import 'dart:math';

import 'package:flutter/material.dart';

import 'src/models/dashboard_models/dashboard_card.model.dart';

final demoUsersList = List.generate(
  20,
  (i) => UsersModel.fromMap({
    'id': i.toString(),
    'avatar':
        'https://cdn.dribbble.com/users/1500210/avatars/normal/ebcc769d2f155e72aa024bdafadc28cc.jpg?1629718724&resize=80x80',
    'name': 'user $i',
    'dateOfBirth': DateTime.now().toLocal(),
    'gender': i.isEven ? "male" : "female",
    'email': 'user$i@codestein.dev',
    'phone': (Random.secure().nextInt(9999999) + 1999999).toString(),
    'status': i.isEven,
  }),
);

class UsersModel {
  final String id;
  final String avatar;
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final String email;
  final String phone;
  bool status;

  UsersModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phone,
    this.status = false,
  });

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      avatar: map['avatar'],
      name: map['name'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      email: map['email'],
      phone: map['phone'],
      status: map['status'] ?? false,
    );
  }
}

final dashboardCardModelValues = [
  DashboardCardModel.fromJson({
    'name': 'Projects',
    'icon': Icons.precision_manufacturing_rounded,
    'value': 327,
    'persentage': 32.1,
    'persentageValue': '2.1',
    'notes': '8k social visitors',
  }),
  DashboardCardModel.fromJson({
    'name': 'Stock Qty',
    'icon': Icons.add_chart_rounded,
    'value': 275,
    'persentage': 64.1,
    'persentageValue': '3.1',
    'notes': 'Total 424,567 deliveries',
  }),
  DashboardCardModel.fromJson({
    'name': 'C APEX',
    'icon': Icons.apple_rounded,
    'value': 648,
    'persentage': 72.1,
    'persentageValue': '12.1',
    'notes': 'Counted in Millions',
  }),
  DashboardCardModel.fromJson({
    'name': 'Saving',
    'icon': Icons.data_saver_off_rounded,
    'value': 18478,
    'persentage': 24.1,
    'persentageValue': '0.1',
    'notes': 'Reports by states and ganders',
  }),
];
