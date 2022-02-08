import 'package:flutter/material.dart';

class Asset extends StatelessWidget {
  const Asset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(_data['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(_data['coverImage']),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Text('Description'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Text(_data['description']),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Text('Views'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Text(_data['views'].toString()),
            ),
          ],
        ),
      ),
    );
  }
}
