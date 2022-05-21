import 'package:flutter/material.dart';

class PaymentSlidingPanel extends StatelessWidget {
  const PaymentSlidingPanel({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme
        .of(context)
        .textTheme;
    ThemeData _themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return ListView(
      controller: scrollController,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Color(0xFF383838),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
            ),
            boxShadow:[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
              )
            ]
          ),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  height: 8.0,
                  width: 70.0,
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Virtual Account',
                    style:
                        _textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 16.0),
                child: Text(
                    'Akan diproses secara otomatis tanpa perlu konfirmasi. Silahkan pilih salah satu.',
                    style: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, color: _themeData.focusColor),
                    textAlign: TextAlign.start),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 8.0),
                child: Text('Silakan Pilih',
                    style: _textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start),
              ),
              Container(
                width: size.width,
                height: 250,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(
                        paymentChoice: choices[index],
                      ),
                    );
                  }),
                ),
              ),
              Text('QRIS',
                  style:
                  _textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start),
              Text(
                  'Bayar praktis dengan scan QRIS',
                  style: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, color: _themeData.focusColor),
                  textAlign: TextAlign.start),
              Text('Pembayaran menggunakan QRIS',
                  style: _textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start),
              ElevatedButton(
                child: Text(
                  "Simpan",
                  style: _textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.8, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    alignment: Alignment.center),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PaymentChoice {
  const PaymentChoice({required this.title, required this.bankPathAsset});
  final String title;
  final String bankPathAsset;
}

const List<PaymentChoice> choices = const <PaymentChoice>[
  const PaymentChoice(title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  const PaymentChoice(title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  const PaymentChoice(title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
  const PaymentChoice(title: 'VA BCA', bankPathAsset: "assets/bank_bca.png"),
  const PaymentChoice(title: 'VA Mandiri', bankPathAsset: "assets/bank_mandiri.png"),
  const PaymentChoice(title: 'VA BRI', bankPathAsset: "assets/bank_bri.png"),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.paymentChoice}) : super(key: key);
  final PaymentChoice paymentChoice;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme
        .of(context)
        .textTheme;
    ThemeData _themeData = Theme.of(context);
    return Card(
        color: _themeData.focusColor,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Image.asset(paymentChoice.bankPathAsset, width: 70.0)),
              Text(paymentChoice.title, style: _textTheme.bodySmall),
            ]
        ),
        )
    );
  }
}
