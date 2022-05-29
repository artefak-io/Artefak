import 'package:flutter/material.dart';

class InputNumberStep extends StatefulWidget {
  final int minValue;
  final int maxValue;

  final ValueChanged<int>? onChanged;

  InputNumberStep(
      {Key? key, this.minValue = 0, this.maxValue = 10, this.onChanged})
      : super(key: key);

  @override
  State<InputNumberStep> createState() {
    return _InputNumberStepState();
  }
}

class _InputNumberStepState extends State<InputNumberStep> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    ThemeData _themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.black,
                width: 60,
                height: 32,
                child: Text(
                  '$counter',
                  textAlign: TextAlign.center,
                  style: _textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Positioned(
                left: 0,
                child: MaterialButton(
                  minWidth: 32,
                  color: _themeData.highlightColor,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.remove,
                    size: 26.0,
                    color: _themeData.textSelectionColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
                  onPressed: () {
                    setState(() {
                      if (counter > widget.minValue) {
                        counter--;
                      }
                      widget.onChanged!(counter);
                    });
                  },
                ),
              ),
              Positioned(
                right: 0,
                child: MaterialButton(
                  minWidth: 32,
                  color: _themeData.highlightColor,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    size: 26.0,
                    color: _themeData.textSelectionColor,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
                  // color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      if (counter < widget.maxValue) {
                        counter++;
                      }
                      widget.onChanged!(counter);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
