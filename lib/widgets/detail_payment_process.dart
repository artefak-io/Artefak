import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPaymentProcess extends StatelessWidget {
  const DetailPaymentProcess({
    Key? key,
  })  : super(key: key);


  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Selesaikan Pembayaran',
              style: _textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Pembayaran dapat dilakukan sebelum:',
              style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400, color: _themeData.focusColor),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 25.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Text(
                  '11 Jam 59 menit 59 detik',
                  style: _textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _themeData.toggleableActiveColor),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: _themeData.shadowColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 48,
            alignment: Alignment.centerLeft,
            child: Text(
              'Kepemilikan tokenmu akan resmi setelah proses pembayaran selesai sebelum batas waktu diatas!',
              style: _textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: _themeData.secondaryHeaderColor),
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Status',
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.focusColor),
                    ),
                    Spacer(),
                    Text(
                      'Menunggu Pembayaran',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Text(
                      'ID Pesanan Token',
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.focusColor),
                    ),
                    Spacer(),
                    Text(
                      'ARTE-8652314681',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Text(
                      'Nama Tujuan',
                      style: _textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: _themeData.focusColor),
                    ),
                    Spacer(),
                    Text(
                      'PT Artefak NFT',
                      style: _textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No. Virtual Account BCA',
                          style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                        ),
                        Text(
                          '89878951132',
                          style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _themeData.highlightColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        height: 32.0,
                        width: 32.0,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.content_copy,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                      onTap: () =>
                          Clipboard.setData(ClipboardData(text: "89878951132"))
                              .then(
                        (value) {
                          final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Bayar',
                          style: _textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                        ),
                        Text(
                          'Rp757.500',
                          style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _themeData.highlightColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        height: 32.0,
                        width: 32.0,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.content_copy,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                      onTap: () =>
                          Clipboard.setData(ClipboardData(text: "757500"))
                              .then(
                                (value) {
                              final snackBar = SnackBar(
                                content: Text('Copied to Clipboard'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                          ),
                    )
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
