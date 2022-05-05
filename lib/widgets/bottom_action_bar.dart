import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    Key? key,
    required ThemeData themeData,
    required TextTheme textTheme,
    required this.size,
  })  : _themeData = themeData,
        _textTheme = textTheme,
        super(key: key);

  final ThemeData _themeData;
  final TextTheme _textTheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _themeData.highlightColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jumlah Token: 3",
                  style: _textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Rp 750.000",
                  style: _textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            ElevatedButton(
              child: Text(
                'Beli Sekarang',
                style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width * 0.4, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  alignment: Alignment.center),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
