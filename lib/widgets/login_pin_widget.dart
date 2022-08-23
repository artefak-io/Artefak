import 'dart:async';

import 'package:artefak/logic/pin/pin_auth/cubit/pin_auth_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPinWidget extends StatefulWidget {
  final String appBarTitle;
  final String bodytitle;
  final String bodySubTitle;
  final Function onCompleteFunction;
  final Function onSubmittedFunction;
  final Function onChangedFunction;
  final Widget blocBuildNotify;
  final Widget blocBuildButton;

  const LoginPinWidget(
      {Key? key,
      required this.appBarTitle,
      required this.bodytitle,
      required this.bodySubTitle,
      required this.onCompleteFunction,
      required this.onSubmittedFunction,
      required this.onChangedFunction,
      required this.blocBuildNotify,
      required this.blocBuildButton})
      : super(key: key);

  @override
  State<LoginPinWidget> createState() => _LoginPinWidgetState();
}

class _LoginPinWidgetState extends State<LoginPinWidget>
    with TickerProviderStateMixin {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
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
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 8.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });

    return BlocBuilder<PinAuthCubit, PinAuthState>(
      builder: (context, state) {
        bool isPinFailure = state.pinAuthStatus == PinAuthStatus.failure;
        if (isPinFailure) controller.forward(from: 0.0);
        return Container(
          height: size.height - size.height * 0.16,
          width: size.width,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Column(children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 20, right: 16),
                        child: Text(widget.bodytitle,
                            style: _textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, bottom: 16, right: 16),
                          child: Text(widget.bodySubTitle,
                              style: _textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: _themeData.indicatorColor),
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ],
                  ),
                ]),
                SizedBox(height: size.height * 0.025),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: AnimatedBuilder(
                      animation: offsetAnimation,
                      builder: (buildContext, child) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 0.0),
                          padding: EdgeInsets.only(
                              left: offsetAnimation.value + 8.0,
                              right: 8.0 - offsetAnimation.value),
                          child: PinCodeTextField(
                            appContext: context,
                            onCompleted: (value) =>
                                widget.onCompleteFunction(value, context),
                            onSubmitted: (value) =>
                                widget.onSubmittedFunction(context),
                            onChanged: (value) =>
                                widget.onChangedFunction(value, context),
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            length: 6,
                            obscureText: true,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(15),
                              fieldHeight: 50,
                              fieldWidth: 45,
                              activeFillColor: hasError
                                  ? Colors.orange
                                  : _themeData.primaryColorDark,
                              selectedFillColor: _themeData.primaryColorDark,
                              activeColor: _themeData.primaryColorDark,
                              selectedColor: _themeData.primaryColorDark,
                              inactiveColor: _themeData.primaryColorDark,
                              inactiveFillColor: _themeData.primaryColorDark,
                            ),
                            cursorColor: Colors.white70,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle:
                                const TextStyle(fontSize: 14, height: 1.6),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: widget.blocBuildNotify,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: widget.blocBuildButton,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
