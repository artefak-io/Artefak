import 'package:flutter/material.dart';

class DescCollectionReview extends StatelessWidget {
  const DescCollectionReview({
    Key? key,
    required TextTheme textTheme,
    required ThemeData themeData,
  })  : _textTheme = textTheme,
        _themeData = themeData,
        super(key: key);

  final TextTheme _textTheme;
  final ThemeData _themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Proyek',
                    style: _textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: _themeData.shadowColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                height: 80,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _themeData.shadowColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                      ),
                      child: Image.asset(
                        "assets/bank_bca.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Lagu Baru untuk Kamu',
                              style: _textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 24.75,
                                height: 24.75,
                                child: Image.asset('assets/propict.png'),
                              ),
                              SizedBox(
                                width: 7.25,
                              ),
                              Text(
                                "Sarah & Friends",
                                style: _textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
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
