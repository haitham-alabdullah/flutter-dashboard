import 'package:get/get.dart';

class AuthProvider extends GetxController {
  final RxBool _isAuth = RxBool(true);

  bool get isAuth => _isAuth.value;
  String? get username => 'Haitham';

  toggleAuth(bool value) {
    _isAuth.value = value;

    update();
  }
}
