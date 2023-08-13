import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController username;
  late final TextEditingController password;
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              '/images/login.jpg',
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value is String && value.isNotEmpty) {
                              return null;
                            }
                            return 'UserName Field is required';
                          },
                          autofocus: true,
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
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value is String && value.isNotEmpty) {
                              return null;
                            }
                            return 'Password Field is required';
                          },
                          autofocus: true,
                          obscureText: !isVisible,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            icon: Icon(Icons.password_rounded),
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
                          keyboardType: TextInputType.visiblePassword,
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
                            onPressed: () {
                              final state = _formKey.currentState!.validate();
                              print(state);
                              if (state) {
                                Get.find<AuthProvider>().toggleAuth(true);
                                Get.toNamed('/');
                              }
                            },
                            child: const Text('Login'),
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
