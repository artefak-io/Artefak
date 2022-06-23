import 'package:flutter/material.dart';

class TitleMintTokenInfo extends StatelessWidget {
  const TitleMintTokenInfo({
    Key? key,
    required Map<String, dynamic> data,
  })  : _data = data,
        super(key: key);

  final Map<String, dynamic> _data;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              _data['name'],
              style: _textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w400, letterSpacing: 0.0),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            child: Text(
              "Mint 7 April 2022",
              style: _textTheme.bodySmall?.copyWith(
                  color: _themeData.focusColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "•",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "231/300 Token",
                  style: _textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400, letterSpacing: 0.0),
                ),
              ],
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: 231 / 300,
                backgroundColor: Colors.grey,
                minHeight: 8,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
