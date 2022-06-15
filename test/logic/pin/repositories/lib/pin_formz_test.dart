// ignore_for_file: prefer_const_constructors
import 'package:artefak/logic/pin/repositories/lib/pin_formz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PinInput", () {
    test("Should return PinInputValidationError.nonNumberInput", () {
      PinInput pinInput = PinInput.dirty(value: "test");
      expect(
          pinInput.numberValidator(), PinInputValidationError.nonNumberInput);
    });
  });
}
