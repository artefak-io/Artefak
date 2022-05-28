import 'package:formz/formz.dart';

enum PinInputValidationError { invalid }

class PinInput extends FormzInput<String, PinInputValidationError> {
  const PinInput.pure({String value = ""}) : super.pure(value);

  const PinInput.dirty({String value = ""}) : super.dirty(value);

  @override
  PinInputValidationError? validator(String value) {
    return (int.tryParse(value) != null && value.length == 6)
        ? null
        : PinInputValidationError.invalid;
  }
}
