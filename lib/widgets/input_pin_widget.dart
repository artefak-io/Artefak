
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InputPinWidget extends StatefulWidget {
  final String phoneNumber;
  final String title;
  final String subTitle;
  const InputPinWidget({Key? key, required this.phoneNumber, required this.title, required this.subTitle}) : super(key: key);

  @override
  State<InputPinWidget> createState() => _InputPinWidgetState();
}

class _InputPinWidgetState extends State<InputPinWidget> {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);


    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Buat Pin', style: _textTheme.headlineMedium),
        backgroundColor: _themeData.primaryColor,
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF434343),
                  Color(0xFF000000)
                ],
              )),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16,bottom: 20, right: 16),
                            child: Text(widget.title,
                                style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFF3F4F6)),
                                textAlign: TextAlign.start
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16,bottom: 16, right: 16),
                        child: Text(widget.subTitle,
                            style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFD1D5DB)),
                            textAlign: TextAlign.start
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      length: 6,
                      obscureText: true,
                      // obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      validator: (v) {
                        // if (v.length < 3) {
                        //   return "I'm from validator";
                        // } else {
                        //   return null;
                        // }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 50,
                          fieldWidth: 45,
                          activeFillColor:
                          hasError ? Colors.orange : Color(0xFF333333),
                          selectedFillColor: Color(0xFF3D3D3D),
                          activeColor: Color(0xFF3D3D3D),
                          selectedColor: Color(0xFF333333),
                          inactiveColor: Color(0xFF3D3D3D),
                          inactiveFillColor: Color(0xFF3D3D3D)
                      ),
                      cursorColor: Colors.white70,
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(fontSize: 14, height: 1.6),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //   child: Text(
              //     hasError ? "*Please fill up all the cells properly" : "",
              //     style: TextStyle(
              //         color: Colors.red,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w400),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // RichText(
              //   textAlign: TextAlign.center,
              //   text: TextSpan(
              //       text: "Didn't receive the code? ",
              //       style: TextStyle(color: Colors.black54, fontSize: 15),
              //       children: [
              //         TextSpan(
              //             text: " RESEND",
              //             recognizer: onTapRecognizer,
              //             style: TextStyle(
              //                 color: Color(0xFF91D3B3),
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16))
              //       ]),
              // ),
              // SizedBox(
              //   height: 14,
              // ),
              // Container(
              //   margin:
              //   const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              //   child: ButtonTheme(
              //     height: 50,
              //     child: FlatButton(
              //       onPressed: () {
              //         // formKey.currentState.validate();
              //         // // conditions for validating
              //         // if (currentText.length != 6 || currentText != "towtow") {
              //         //   errorController.add(ErrorAnimationType
              //         //       .shake); // Triggering error shake animation
              //         //   setState(() {
              //         //     hasError = true;
              //         //   });
              //         // } else {
              //         //   setState(() {
              //         //     hasError = false;
              //         //     scaffoldKey.currentState.showSnackBar(SnackBar(
              //         //       content: Text("Aye!!"),
              //         //       duration: Duration(seconds: 2),
              //         //     ));
              //         //   });
              //         // }
              //       },
              //       child: Center(
              //           child: Text(
              //             "VERIFY".toUpperCase(),
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.bold),
              //           )),
              //     ),
              //   ),
              //   decoration: BoxDecoration(
              //       color: Colors.green.shade300,
              //       borderRadius: BorderRadius.circular(5),
              //       boxShadow: [
              //         BoxShadow(
              //             color: Colors.green.shade200,
              //             offset: Offset(1, -2),
              //             blurRadius: 5),
              //         BoxShadow(
              //             color: Colors.green.shade200,
              //             offset: Offset(-1, 2),
              //             blurRadius: 5)
              //       ]),
              // ),
              SizedBox(
                height: 16,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text("Clear", style: TextStyle(color: Colors.white),),
              //       onPressed: () {
              //         textEditingController.clear();
              //       },
              //     ),
              //   ],
              // )
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      child: Text('Lanjut', style: _textTheme.button?.copyWith(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF))),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * 0.4, 54),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onPressed: () {},
                      // onPressed: (){},
                      // onPressed: () async {
                      //   if (_formKey.currentState!.validate()) {
                      //     User? result = await AuthService().signInEmailPass(
                      //         _emailController.text,
                      //     );
                      //     if (result == null) {
                      //       print('error signing in');
                      //     } else {
                      //       print(result);
                      //     }
                      //   }
                      // },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   key: scaffoldKey,
    //   appBar: AppBar(
    //     title: Text('Buat Pin', style: _textTheme.headlineMedium),
    //   ),
    //   body:
    //   Container(
    //     height: MediaQuery.of(context).size.height,
    //           width: MediaQuery.of(context).size.width,
    //     decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //           begin: Alignment.topLeft,
    //           end: Alignment.bottomCenter,
    //           colors: [
    //             Color(0xFF434343),
    //             Color(0xFF000000)
    //           ],
    //         )),
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(left: 16,bottom: 16, top: 32, right: 16),
    //           child: Text('Kunci Akses Baru',
    //               style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFF3F4F6)),
    //               textAlign: TextAlign.start
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 16,bottom: 16, top: 32, right: 16),
    //           child: Text('Masukkan 6 digit Pin yang dibuat untuk memudahkan akses dan keamanan yang lebih baik.',
    //               style: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFD1D5DB)),
    //               textAlign: TextAlign.start
    //           ),
    //         ),
    //         Row(
    //           children: [
    //             Container(
    //               child: Form(
    //         key: formKey,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
    //             child:
    //             PinCodeTextField(
    //                                 appContext: context,
    //                                 pastedTextStyle: TextStyle(
    //                                   color: Colors.green.shade600,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                                 length: 6,
    //                                 obscureText: false,
    //                                 obscuringCharacter: '*',
    //                                 animationType: AnimationType.fade,
    //                                 validator: (v) {
    //                                   // if (v.length < 3) {
    //                                   //   return "I'm from validator";
    //                                   // } else {
    //                                   //   return null;
    //                                   // }
    //                                 },
    //                                 pinTheme: PinTheme(
    //                                   shape: PinCodeFieldShape.box,
    //                                   borderRadius: BorderRadius.circular(5),
    //                                   fieldHeight: 60,
    //                                   fieldWidth: 50,
    //                                   activeFillColor:
    //                                   hasError ? Colors.orange : Colors.white,
    //                                 ),
    //                                 cursorColor: Colors.black,
    //                                 animationDuration: Duration(milliseconds: 300),
    //                                 textStyle: TextStyle(fontSize: 20, height: 1.6),
    //                                 backgroundColor: Colors.blue.shade50,
    //                                 enableActiveFill: true,
    //                                 errorAnimationController: errorController,
    //                                 controller: textEditingController,
    //                                 keyboardType: TextInputType.number,
    //                                 boxShadows: [
    //                                   BoxShadow(
    //                                     offset: Offset(0, 1),
    //                                     color: Colors.black12,
    //                                     blurRadius: 10,
    //                                   )
    //                                 ],
    //                                 onCompleted: (v) {
    //                                   print("Completed");
    //                                 },
    //                                 // onTap: () {
    //                                 //   print("Pressed");
    //                                 // },
    //                                 onChanged: (value) {
    //                                   print(value);
    //                                   setState(() {
    //                                     currentText = value;
    //                                   });
    //                                 },
    //                                 beforeTextPaste: (text) {
    //                                   print("Allowing to paste $text");
    //                                   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
    //                                   //but you can show anything you want here, like your pop up saying wrong paste format or etc
    //                                   return true;
    //                                 },
    //                               ),
    //           )
    //               )
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    //   // bottomNavigationBar: const BotNavBar(
    //   //   currentIndex: 2,
    //   // ),
    // );
  }
}
