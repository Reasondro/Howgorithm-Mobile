import 'package:flutter/material.dart';
import 'package:howgorithm/auth/auth_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:howgorithm/extensions/snackbar_extension.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final AuthService authService = AuthService();

  bool _isSignIn = true;
  bool _isAuthenticating = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void signIn() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      context.customShowErrorSnackBar('Please enter your email and password');
      return;
    }

    FocusScope.of(context).unfocus();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      await authService.signInWithEmailPassword(
          email: email, password: password);
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      context.customShowErrorSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      context.customShowErrorSnackBar("Error: $e");
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _isAuthenticating = false;
    });
    // context.go(Routes.homeScreen);
  }

  void signUp() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      context.customShowErrorSnackBar('Please enter your email and password');
      return;
    }
    FocusScope.of(context).unfocus();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      await authService.signUpWithEmailPassword(
          email: email, password: password);
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      context.customShowErrorSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      context.customShowErrorSnackBar("Error: $e");
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _isAuthenticating = false;
    });
    // context.go(Routes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 200, left: 16),
        // const EdgeInsets.only(top: 80, right: 16, bottom: 10, left: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 90,
                    backgroundImage: AssetImage('assets/images/auth-icon.png'),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15)),
                  Text(
                    "HOWGORITHM",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        // color: Theme.of(context).colorScheme.primaryContainer,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 35),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 15))
                ],
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isSignIn ? "Email" : "Your email",
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(200, 0, 0, 0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isSignIn ? "Password" : "Your password",
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      style:
                          const TextStyle(color: Color.fromARGB(200, 0, 0, 0)),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 4,
              // ),
              if (_isAuthenticating) const CircularProgressIndicator(),
              if (!_isAuthenticating)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isSignIn) {
                        signIn();
                      } else {
                        signUp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      _isSignIn ? "Sign in" : "Sign up",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

              if (!_isAuthenticating)
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _emailController.clear();
                    _passwordController.clear();
                    setState(() {
                      _isSignIn = !_isSignIn;
                    });
                  },
                  child: Text(
                    _isSignIn
                        ? "Create an account"
                        : "I already have an account",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              // SizedBox(
              //   height: 150,
              // )
            ]),
      ),
    );
  }
}
