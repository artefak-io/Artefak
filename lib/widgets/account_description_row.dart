import 'package:artefak/widgets/sub_head_title.dart';
import 'package:flutter/material.dart';

class AccountDescriptionRow extends StatelessWidget {
  const AccountDescriptionRow({
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            height: 56,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Image.asset('assets/propict.png'),
                ),
                Text("Sarah & Friends",
                  style: _textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w400),),
                Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      color: _themeData.focusColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  child: Text(
                    "Ikuti",
                    style: _textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 16.0, bottom: 8.0),
                  child: Text(
                    "Detail Proyek",
                    style: _textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Text(
                    "Tiramisu pie danish jelly happy jolie. Mclaukin clackuin queen mister clean.",
                    style: _textTheme.bodyMedium
                        ?.copyWith(color: _themeData.focusColor),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 8.0, bottom: 24.0),
                  alignment: Alignment.topRight,
                  child: Text(
                    "Baca Selengkapnya",
                    style: _textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _themeData.hintColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          SubHeadTitle(
            title: "Menarik Lainnya",
            isSeeAll: true,
          ),
        ],
      ),
    );
  }
}
