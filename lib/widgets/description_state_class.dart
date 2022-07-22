import 'package:flutter/material.dart';

class DescriptionStateClass extends StatefulWidget {
  const DescriptionStateClass({
    Key? key,
    required Map<String, dynamic> data,
  })  : _data = data,
        super(key: key);

  final Map<String, dynamic> _data;

  @override
  State<DescriptionStateClass> createState() => _DescriptionStateClassState();
}

class _DescriptionStateClassState extends State<DescriptionStateClass> {
  bool _isExpanded = false;
  int _maxLength = 100;

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
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
              widget._data['description'],
              style:
                  _textTheme.bodyMedium?.copyWith(color: _themeData.focusColor),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: _isExpanded ? 25 : 2,
            ),
          ),
          widget._data['description'].length > _maxLength
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 8.0, bottom: 24.0),
                    alignment: Alignment.topRight,
                    child: Text(
                      _isExpanded ? "Sembunyikan" : "Baca Selengkapnya",
                      style: _textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _themeData.hintColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              : SizedBox(
                  height: 24.0,
                ),
        ],
      ),
    );
  }
}
