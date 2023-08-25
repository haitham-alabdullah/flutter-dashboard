import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:dashboard/src/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../classes/enums.class.dart';
import '../../../classes/functions.class.dart';
import '../../../widgets/simple_loader.widget.dart';
import '../../../widgets/notifications_widgets/alert.widget.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisible = false;
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  update(VoidCallback func) {
    if (mounted) setState(func);
  }

  bool validate() {
    final email = emailController.text;
    final pass = passwordController.text;
    if (email.isEmpty) {
      return !setError('The email address is required');
    }
    if (!email.isEmail) {
      return !setError('The email address is inviled');
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
      initializeProviders();
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
      body: ResponsiveWidget(
        builder: (cnx, screen) => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: !screen.isMobile
              ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imgUrl('login.jpg')),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          child: Center(
            child: SingleChildScrollView(
              physics: screen.isDesktop
                  ? const NeverScrollableScrollPhysics()
                  : null,
              child: Container(
                width: !screen.isMobile ? 550 : null,
                decoration: BoxDecoration(
                  color: !screen.isMobile ? Colors.white : null,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Welcome Back',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                              controller: emailController,
                              autofocus: true,
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: SizedBox(
                                  width: 20,
                                  child: svg(
                                    'profile',
                                    color: Colors.grey.shade800,
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
                              onEditingComplete:
                                  TextInput.finishAutofillContext,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              autofillHints: const [AutofillHints.password],
                              controller: passwordController,
                              autofocus: false,
                              obscureText: !isVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                icon: SizedBox(
                                  width: 20,
                                  child: svg(
                                    'password',
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: IconButton(
                                    onPressed: togglePass,
                                    icon: isVisible
                                        ? svg('eye.slash.fill',
                                            size: 16,
                                            color: Colors.grey.shade800)
                                        : svg('eye.fill',
                                            size: 15,
                                            color: Colors.grey.shade800),
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
                              onEditingComplete:
                                  TextInput.finishAutofillContext,
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.visiblePassword,
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
                                  secondChild: const Center(
                                    child: SimpleLoader(
                                      strokeWidth: 3,
                                      size: 20,
                                    ),
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
        ),
      ),
    );
  }
}
