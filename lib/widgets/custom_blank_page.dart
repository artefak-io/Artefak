import 'package:flutter/material.dart';

class CustomBlankPage extends StatelessWidget {
  const CustomBlankPage({
    Key? key, required this.onClickHome,
  }) : super(key: key);

  final Function onClickHome;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        width: size.width * 0.88,
        decoration: BoxDecoration(
          color: _themeData.cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sedang kita bangun halaman ini',
              style: _textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              'Dibangun dengan penuh rasa 💛 💜 Silahkan menuju beranda untuk mendapatkan proyek menarik lainnya',
              style: _textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: _themeData.indicatorColor,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: _themeData.focusColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  minimumSize: Size(
                    190.0,
                    48.0,
                  )),
              child: Text(
                "Kembali ke Beranda",
                style: _textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              onPressed: () => onClickHome(),
            ),
          ],
        ),
      ),
    );
  }
}