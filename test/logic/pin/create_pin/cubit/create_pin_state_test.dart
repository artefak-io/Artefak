// ignore_for_file: prefer_const_constructors
import 'package:artefak/logic/pin/pin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("CreatePinState", (() {
    test("returns same object when no arguments were passed ", () {
      expect(CreatePinState().copyWith(), CreatePinState());
    });
    test(
        "should equal when both CreatePinState's createPinStatus and invalid have the same value",
        () {
      final state1 = CreatePinState().copyWith(
        pinInput: PinInput.dirty(value: "should"),
        createPinStatus: CreatePinStatus.success,
        invalid: PinInputValidationError.noError,
      );
      final state2 = CreatePinState().copyWith(
        pinInput: PinInput.dirty(value: "equal"),
        createPinStatus: CreatePinStatus.success,
        invalid: PinInputValidationError.noError,
      );
      expect(state1 == state2, true);
    });
    test(
        "shouldn't equal when both  CreatePinState's createPinStatus have different value",
        () {
      final state1 = CreatePinState().copyWith(
        pinInput: PinInput.dirty(value: "shouldn't equal"),
        createPinStatus: CreatePinStatus.success,
        invalid: PinInputValidationError.insufficientLength,
      );
      final state2 = CreatePinState().copyWith(
        pinInput: PinInput.dirty(value: "shouldn't equal"),
        createPinStatus: CreatePinStatus.inputValid,
        invalid: PinInputValidationError.insufficientLength,
      );
      expect(state1 == state2, false);
    });
    test(
        "shouldn't equal when both  CreatePinState's invalid have different value",
        () {
      final state1 = CreatePinState().copyWith(
        pinInput: PinInput.dirty(value: "test"),
        createPinStatus: CreatePinStatus.inputInvalid,
        invalid: PinInputValidationError.insufficientLength,
      );
      final state2 = CreatePinState().copyWith(
        pinInput: PinInput.dirty(value: "test"),
        createPinStatus: CreatePinStatus.inputInvalid,
        invalid: PinInputValidationError.nonNumberInput,
      );
      expect(state1 == state2, false);
    });
  }));
}
