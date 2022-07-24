import 'package:flutter/material.dart';

class TitleMintTokenInfo extends StatelessWidget {
  const TitleMintTokenInfo({
    Key? key,
    required Map<String, dynamic> data,
    required this.mintTokenCollection,
  })  : _data = data,
        super(key: key);

  final Map<String, dynamic> _data;
  final MintTokenCollection mintTokenCollection;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              _data['name'],
              style: _textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w400, letterSpacing: 0.0),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "•",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
                mintTokenCollection.isTokenized
                    ? Text(
                        "Aktif #" + mintTokenCollection.nftSeries.toString(),
                        style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400, letterSpacing: 0.0),
                      )
                    : Text(
                        mintTokenCollection.amountOwnToken.toString() +
                            "/" +
                            mintTokenCollection.totalAllToken.toString() +
                            " Token",
                        style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.0,
                        ),
                      ),
              ],
            ),
          ),
          mintTokenCollection.isTokenized
              ? Container()
              : Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: LinearProgressIndicator(
                          value: mintTokenCollection.amountOwnToken /
                              mintTokenCollection.totalAllToken,
                          backgroundColor: Colors.grey,
                          minHeight: 8,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class MintTokenCollection {
  final bool isTokenized;
  final int amountOwnToken;
  final int totalAllToken;
  final int nftSeries;

  MintTokenCollection(this.isTokenized, this.amountOwnToken, this.totalAllToken,
      this.nftSeries);
}
