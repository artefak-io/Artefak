import 'package:artefak/widgets/select_card_payment.dart';
import 'package:flutter/material.dart';

class PaymentSlidingPanel extends StatefulWidget {
  const PaymentSlidingPanel({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<PaymentSlidingPanel> createState() => _PaymentSlidingPanelState();
}

class _PaymentSlidingPanelState extends State<PaymentSlidingPanel> {
  List<ListSelectedPayment<PaymentChoice>> list = [];
  List<String> listQris = [];
  String? qris;

  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    for (int i = 0; i < choices.length; i++)
      list.add(ListSelectedPayment<PaymentChoice>(choices[i]));
    list.add(ListSelectedPayment<PaymentChoice>(
        PaymentChoice(title: "QRIS", bankPathAsset: "")));

    listQris.add("assets/CIMB.png");
    listQris.add("assets/DANA.png");
    listQris.add("assets/GOPAY.png");
    listQris.add("assets/OVO.png");
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF383838),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
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
                  width: 55.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              Container(
                height: size.height * 0.8 - 24.0,
                child: ListView(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Virtual Account',
                          style: _textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                          'Akan diproses secara otomatis tanpa perlu konfirmasi. Silahkan pilih salah satu.',
                          style: _textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text('Silakan Pilih',
                          style: _textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      width: size.width,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 8.0,
                        children: List.generate(choices.length, (index) {
                          return Center(
                            child: SelectCardPayment(
                              paymentChoice: choices[index],
                              isSelected: list[index].isSelected,
                              onSelectValue: (bool value) {
                                if (list.any((item) => item.isSelected)) {
                                  qris = null;
                                  for (var i = 0; i < list.length; i++) {
                                    list[i].isSelected = false;
                                  }
                                }
                                setState(() {
                                  list[index].isSelected =
                                      !list[index].isSelected;
                                });
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 8.0, top: 32.0),
                      child: Text('QRIS',
                          style: _textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text('Bayar praktis dengan scan QRIS',
                          style: _textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                          textAlign: TextAlign.start),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Pembayaran menggunakan QRIS',
                            style: _textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            textAlign: TextAlign.start),
                        Spacer(),
                        Radio(
                          value: list.length.toString(),
                          groupValue: qris,
                          onChanged: (value) {
                            if (list.any((item) => item.isSelected)) {
                              for (var i = 0; i < list.length; i++) {
                                list[i].isSelected = false;
                              }
                            }
                            setState(() {
                              qris = value.toString();
                              list[int.parse(value.toString()) - 1].isSelected =
                                  !list[int.parse(value.toString()) - 1]
                                      .isSelected;
                            });
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      children: List.generate(listQris.length, (index) {
                        return Container(
                            margin: EdgeInsets.only(right: 8.4),
                            child: Image.asset(listQris[index]));
                      }),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      child: Text(
                        "Simpan",
                        style: _textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width * 0.8, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          alignment: Alignment.center),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ListSelectedPayment<T> {
  bool isSelected = false;
  T data;

  ListSelectedPayment(this.data);
}
