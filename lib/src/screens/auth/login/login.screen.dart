import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../classes/functions.class.dart';
import '../../../widgets/simple_loader.widget.dart';
import '../../../widgets/alert.widget.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isVisible = false;
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  update(VoidCallback func) {
    if (mounted) setState(func);
  }

  bool validate() {
    final name = username.text;
    final pass = password.text;
    if (name.isEmpty) {
      return !setError('The username is required');
    }
    if (pass.isEmpty) {
      return !setError('The password is required');
    }
    return true;
  }

  login() async {
    setError(null);
    update(() => isLoading = true);
    final state = validate();
    if (state) {
      TextInput.finishAutofillContext();
      await Future.delayed(const Duration(seconds: 1), () {
        Get.find<AuthProvider>().toggleAuth(true);
        Get.offAllNamed('/');
      });
    }
    update(() => isLoading = false);
  }

  bool setError(String? value) {
    if (error == null && value == null) return false;
    if (mounted) setState(() => error = value);
    return error is String;
  }

  togglePass() {
    if (mounted) setState(() => isVisible = !isVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imgUrl('login.jpg'),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 550,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff0f0f0f),
                      ),
                ),
                const SizedBox(height: 50),
                if (error is String) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Alert(
                      error!,
                      type: AlertType.danger,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        TextField(
                          controller: username,
                          autofocus: true,
                          autofillHints: const [AutofillHints.username],
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            icon: Icon(Icons.person_rounded),
                            filled: true,
                            fillColor: Color(0xFFf0f1f5),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFf0f1f5),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFf0f1f5),
                              ),
                            ),
                          ),
                          onChanged: (value) => setError(null),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          autofillHints: const [AutofillHints.password],
                          controller: password,
                          autofocus: false,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            icon: const Icon(Icons.password_rounded),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: IconButton(
                                onPressed: togglePass,
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFf0f1f5),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFf0f1f5),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFf0f1f5),
                              ),
                            ),
                          ),
                          onChanged: (value) => setError(null),
                          textInputAction: TextInputAction.go,
                          onSubmitted: (_) => login(),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: isLoading ? null : login,
                            child: AnimatedCrossFade(
                              crossFadeState: !isLoading
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              firstChild: const Text('Login'),
                              secondChild: const SimpleLoader(
                                strokeWidth: 3,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50, width: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
