import 'package:artefak/screens/main/collection_review.dart';
import 'package:artefak/widgets/select_card_payment.dart';
import 'package:flutter/material.dart';

class PaymentSlidingPanel extends StatefulWidget {
  const PaymentSlidingPanel(
      {Key? key,
      required this.scrollController,
      required this.listVA, required this.listAllMethod,})
      : super(key: key);

  final ScrollController scrollController;
  final List<ListSelectedPayment<PaymentChoice>> listAllMethod;
  final List<String> listVA;

  @override
  State<PaymentSlidingPanel> createState() => _PaymentSlidingPanelState();
}

class _PaymentSlidingPanelState extends State<PaymentSlidingPanel> {
  String? _qris;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    List<ListSelectedPayment<PaymentChoice>> _listAllMethod = List.from(widget.listAllMethod);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _themeData.canvasColor,
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
                  margin: EdgeInsets.symmetric(
                      vertical: 8.0),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0),
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0),
                      child: Text('Virtual Account',
                          style: _textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          bottom: 16.0),
                      child: Text(
                          'Akan diproses secara otomatis tanpa perlu konfirmasi. Silahkan pilih salah satu.',
                          style: _textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: _themeData.focusColor),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          bottom: 8.0),
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
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        children: List.generate(choices.length, (index) {
                          return Container(
                            child: SelectCardPayment(
                              paymentChoice: choices[index],
                              isSelected:
                                  _listAllMethod[index].isSelected,
                              onSelectValue: (bool value) {
                                setState(() {
                                  _qris = null;
                                  for (var i = 0;
                                      i < _listAllMethod.length;
                                      i++)
                                    _listAllMethod[i].isSelected = false;
                                  _listAllMethod[index].isSelected =
                                      !_listAllMethod[index].isSelected;
                                });
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          bottom: 8.0,
                          top: 32.0),
                      child: Text('QRIS',
                          style: _textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
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
                          value: _listAllMethod.length.toString(),
                          groupValue: _qris,
                          onChanged: (value) {
                            setState(() {
                              _qris = value.toString();
                              for (var i = 0;
                                  i < _listAllMethod.length;
                                  i++)
                                _listAllMethod[i].isSelected = false;
                              _listAllMethod[int.parse(_qris!) - 1]
                                      .isSelected =
                                  !_listAllMethod[int.parse(_qris!) - 1]
                                      .isSelected;
                            });
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      children: List.generate(widget.listVA.length, (index) {
                        return Container(
                            margin: EdgeInsets.only(
                                right: 8.4),
                            child: Image.asset(widget.listVA[index]));
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
                          minimumSize: Size(size.width * 0.8, 48.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          alignment: Alignment.center),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
