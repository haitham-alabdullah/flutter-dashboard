import 'dart:math';

final demoUsersList = List.generate(
  500,
  (i) => UsersModel.fromMap({
    'id': i.toString(),
    'avatar':
        'https://cdn.dribbble.com/users/1500210/avatars/normal/ebcc769d2f155e72aa024bdafadc28cc.jpg?1629718724&resize=80x80',
    'name': 'user $i',
    'dateOfBirth': DateTime.now().toLocal(),
    'gender': i.isEven ? Gender.male : Gender.female,
    'email': 'user$i@codestein.dev',
    'phone': (Random.secure().nextInt(9999999) + 1999999).toString(),
  }),
);

enum Gender {
  male,
  female,
}

class UsersModel {
  final String id;
  final String avatar;
  final String name;
  final DateTime dateOfBirth;
  final Gender gender;
  final String email;
  final String phone;

  UsersModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phone,
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
    );
  }
}
