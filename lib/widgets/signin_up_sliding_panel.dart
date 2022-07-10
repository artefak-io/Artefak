import 'package:flutter/material.dart';

// mixin ShowDialogAuth on StatefulWidget {
  void showDialogAuth(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.5,
            maxChildSize: 0.6,
            builder:
                (BuildContext context, ScrollController scrollController) =>
                    SignInUpSlidingPanel(
              scrollController: scrollController,
            ),
          );
        },
      );
    });
  }
// }

class SignInUpSlidingPanel extends StatefulWidget {
  SignInUpSlidingPanel({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<SignInUpSlidingPanel> createState() => _SignInUpSlidingPanelState();
}

class _SignInUpSlidingPanelState extends State<SignInUpSlidingPanel> {
  final _emailController = TextEditingController();
  String _emailText = "";

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _emailText = _emailController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _themeData.canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  height: 8.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              Container(
                height: size.height * 0.6 - 24.0,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Masuk / Daftar Akun Dulu',
                          style: _textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                          'Sapa masa depanmu! Kita percaya masa depan selalu lebih baik, miliki dan mulai sekarang!',
                          style: _textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      child: Text('Masukkan email / nomor HP aktifmu',
                          style: _textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.indicatorColor),
                          textAlign: TextAlign.start),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      decoration: BoxDecoration(
                        color: _themeData.primaryColorDark,
                        border: Border.all(width: 1, color: Colors.black26),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          suffixIcon: _emailText.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _emailController.clear();
                                    });
                                  },
                                ),
                          labelText: 'Email / no HP',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Mulai Sekarang!',
                        style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width * 0.4, 48.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          alignment: Alignment.center),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'Dengan masuk atau mendaftar, saya menyetujui ',
                              style: _textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Syarat dan Ketentuan ',
                              style: _textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.hintColor,
                              ),
                            ),
                            TextSpan(
                              text: 'serta ',
                              style: _textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Kebijakan Privasi',
                              style: _textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: _themeData.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
