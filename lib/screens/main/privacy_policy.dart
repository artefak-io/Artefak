import 'package:artefak/screens/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/privacy_policy.txt');
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return AppLayout(
      appBar: AppBar(
        backgroundColor: _themeData.primaryColor,
        title: Text(
          'Kebijakan Privasi',
          style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12.0),
                  padding: EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _themeData.shadowColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                        future: loadAsset(),
                        initialData: "Loading text..",
                        builder:
                            (BuildContext context, AsyncSnapshot<String> text) {
                          return SingleChildScrollView(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                text.data ?? 'Loading text..',
                                style: _textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.justify,
                              ));
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
