import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.9,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentpage = value;
            });
          },
          controller: controller,
          itemBuilder: (context, index) => builder(index),
          itemCount: 2,
        ),
      ),
    );
  }

  builder(int index, {String? currencyLabel, int? balance}) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = (controller.page! - index);
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: 120, //Curves.easeOut.transform(value) * 300,
            width: 500, //Curves.easeOut.transform(value) * 750,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 14),
                  blurRadius: 20,
                  color: const Color(0xFFC6C6C6).withOpacity(0.23))
            ]),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 70,
              decoration: BoxDecoration(
                  color: const Color(0x9CDCDCDC),
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: const _ProfileCarouselItem(
                  currencyLabel: 'IDR', balance: 5000),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top up',
                    style: GoogleFonts.inter(
                        // TODO: ada nft wallet, nggk a da cryptowallet
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                  ),
                  Text(
                    'Withdraw',
                    style: GoogleFonts.inter(
                        // TODO:
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                  ),
                  Text(
                    'Convert',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileCarouselItem extends StatelessWidget {
  final String? currencyLabel;
  final int? balance;

  const _ProfileCarouselItem({Key? key, this.currencyLabel, this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);

    return Row(
      children: [
        currencyLabel == 'IDR'
            ? SizedBox(
                child: Image.asset('assets/idr.png'),
              )
            : SizedBox(
                child: Image.asset('assets/idr.png'),
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('IDR Balance',
                style: _textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500)),
            Text(NumberFormat.simpleCurrency(locale: 'in').format(balance),
                style: _textTheme.headlineMedium?.copyWith(color: _themeData.highlightColor)),
          ],
        )
      ],
    );
  }
}
