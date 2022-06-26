import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AssetPreview extends StatelessWidget {
  const AssetPreview({
    Key? key,
    required Map<String, dynamic> data,
  })  : _data = data,
        super(key: key);

  final Map<String, dynamic> _data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
      width: size.width,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: _data['coverImage'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  cacheManager: CacheManager(Config(
                    "assetImage",
                    stalePeriod: const Duration(days: 7),
                    //one week cache period
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: _themeData.highlightColor,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: _themeData.highlightColor,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                height: 40,
                child: Text("12 Jam 30 Detik",
                    style: _textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
