import 'package:flutter/material.dart';

class ScrollViewSignIn extends StatelessWidget {
  final ScrollController scrollController;
  final List images;

  const ScrollViewSignIn(
      {Key? key, required this.scrollController, required this.images})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/${images[index]}',
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
