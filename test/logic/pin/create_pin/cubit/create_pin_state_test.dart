// ignore_for_file: prefer_const_constructors
import 'package:artefak/logic/pin/pin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreatePinState', () {
    test("should equal", () {
      final state1 = CreatePinState(
        pinInput: PinInput.dirty(value: "test"),
        createPinStatus: CreatePinStatus.success,
      );
      final state2 = CreatePinState(
        pinInput: PinInput.dirty(value: "abc"),
        createPinStatus: CreatePinStatus.success,
      );
      expect(state1 == state2, true);
    });
    test("shouldn't equel", () {
      final state1 = CreatePinState(
        pinInput: PinInput.dirty(value: "test"),
        createPinStatus: CreatePinStatus.success,
      );
      final state2 = CreatePinState(
        pinInput: PinInput.dirty(value: "test"),
        createPinStatus: CreatePinStatus.inputValid,
      );
      expect(state1 == state2, false);
    });
  });
}
