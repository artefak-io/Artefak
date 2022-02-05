import 'dart:convert';

import 'package:artefak/models/collections.dart';
import 'package:artefak/widgets/bottom_navbar.dart';
import 'package:artefak/widgets/collection_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<List<Collection>> fetchCollection() async {
    Response response =
        await get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body))
          .map<Collection>((json) => Collection(json))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Collection>>(
          future: fetchCollection(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return CollectionList(collection: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const BotNavBar(),
    );
  }
}
