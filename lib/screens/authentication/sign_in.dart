import 'package:artefak/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*required';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*required';
                      } else if (value.length < 6) {
                        return 'password must be at least 6 digits';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? result = await AuthService().signInEmailPass(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (result == null) {
                        print('error signing in');
                      } else {
                        print(result);
                      }
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('sign in anon'),
                  onPressed: () async {
                    User? result = await AuthService().signInAnon();
                    if (result == null) {
                      print('error signing in anonymously');
                    } else {
                      print(result);
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () => Navigator.popAndPushNamed(
                    context,
                    '/signup',
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
