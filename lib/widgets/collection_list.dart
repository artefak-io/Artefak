import 'package:artefak/models/collections.dart';
import 'package:flutter/material.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({Key? key, required this.collection}) : super(key: key);

  final List<Collection> collection;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: collection.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (context, index) {
        return Image.network(collection[index].url);
      },
    );
  }
}
