import 'package:flutter/material.dart';

class SubHeadTitle extends StatelessWidget {
  final String title;
  final bool isSeeAll;

  const SubHeadTitle({
    Key? key,
    required this.title,
    required this.isSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: _textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          Spacer(),
          isSeeAll
              ? TextButton(
                  child: Text(
                    "Lihat Semua",
                    style: _textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _themeData.hintColor,
                    ),
                  ),
                  onPressed: () {},
                )
              : Container(),
        ],
      ),
    );
  }
}
