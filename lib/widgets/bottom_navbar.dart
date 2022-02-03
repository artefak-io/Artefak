import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Material(
            color: Colors.amber,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue,
              child: SizedBox(
                width: 100,
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search,
                    ),
                    Text(
                      'Search',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 5.0,
            width: 5.0,
            color: Colors.black,
          ),
          Material(
            color: Colors.amber,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.blue[100],
              child: SizedBox(
                width: 100,
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.account_circle_outlined,
                    ),
                    Text(
                      'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
