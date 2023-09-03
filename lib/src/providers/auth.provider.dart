import 'package:dashboard/src/screens/auth/login/login.screen.dart';
import 'package:get/get.dart';

import '../classes/functions.class.dart';
import '../models/app_models/user.model.dart';

class AuthProvider extends GetxController {
  final Rx<UserModel?> _profile = Rx<UserModel>(UserModel(
      'Haitham Ahmed',
      'haithamahmad16995@gmail.com',
      'https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80'));
  final RxBool _isAuth = RxBool(true);

  bool get isAuth => _isAuth.value;
  UserModel? get profile => _profile.value;
  String? get username => 'Haitham';

  Future<void> toggleAuth(bool value) async {
    _isAuth.value = value;
    await removeProviders();
    update();
  }

  void logout() async {
    _isAuth.value = false;
    update();
    await removeProviders();
    Get.offAllNamed(LoginScreen.route);
  }
}
