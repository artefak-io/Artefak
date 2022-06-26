import 'package:flutter/material.dart';

class QrTicketSlidingPanel extends StatelessWidget {
  const QrTicketSlidingPanel({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

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
                      child: Text('Akses Tiket #007',
                          style: _textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                          'Tunjukkan QR Code ini di event supaya dapat akses spesial!',
                          style: _textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      child: Image.asset("assets/qr_sample.png",),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    ElevatedButton(
                      child: Text(
                        'OK',
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
