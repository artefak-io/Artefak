import 'package:flutter/material.dart';

class CollectionEachItem extends StatelessWidget {
  const CollectionEachItem({
    Key? key,
    required TextTheme textTheme,
    required ThemeData themeData,
  }) : _textTheme = textTheme, _themeData = themeData, super(key: key);

  final TextTheme _textTheme;
  final ThemeData _themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
            alignment: Alignment.center,
            height: 66,
            decoration: BoxDecoration(
              color: Color(0xFF252525),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: CircleAvatar(
                    child: Text('H',
                        style: _textTheme.bodySmall),
                    radius: 32,
                    backgroundColor: Colors.white30,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Tiket',
                          style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        child: Text(
                          '19 Juni 2022',
                          style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: _themeData.toggleableActiveColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Koleksi Aktif",
                      style: _textTheme.bodySmall?.copyWith(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 328,
            child: SizedBox(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.center,
            height: 86,
            decoration: BoxDecoration(
              color: Color(0xFF252525),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        'Konser “Kita - Kamu - Aku”',
                        style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 7.25),
                          child: CircleAvatar(
                            child: Text('H',
                                style: _textTheme.bodySmall),
                            radius: 12,
                            backgroundColor: Colors.white30,
                          ),
                        ),
                        Text(
                          'Monalisa Anita',
                          style: _textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                      ],),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "#888",
                        style: _textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Akses',
                        style: _textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(67.0, 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          alignment: Alignment.center),
                      onPressed: () => {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}