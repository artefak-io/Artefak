import 'package:artefak/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final VoidCallback toggleView;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.3,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.3,
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: AssetImage('assets/backgroundLogin.png'),
                                fit: BoxFit.contain,
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(26),
                                  bottomRight: Radius.circular(26)
                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                      height: 30
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Sign Up', style: _textTheme.subtitle1?.copyWith(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w600)),
                                SizedBox(
                                    height: 18
                                ),
                                Text('You want to Join Us? Insert Email and Password.', style: _textTheme.displayMedium,
                                    textAlign: TextAlign.center
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child:
                    Form(
                      key: _formKey,
                      child: Column (
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.black26
                                  ),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'E-mail',
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
                            Container(
                              transform: Matrix4.translationValues(0.0, -1.0, 0.0),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.black26
                                  ),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                              ),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Password',
                                ),
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

                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              child: Text('Sign Up', style: _textTheme.button?.copyWith(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF))),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(size.width * 0.9, 54),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? result = await AuthService().signUpEmailPass(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  if (result == null) {
                                    print('error signing up');
                                  } else {
                                    print(result);
                                  }
                                }
                              },
                            ),
                            ElevatedButton(
                              onPressed: () => widget.toggleView(),
                              child: Text('Sign In', style: _textTheme.button?.copyWith(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF))),
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
