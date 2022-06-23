import 'package:formz/formz.dart';

enum PinInputValidationError {
  insufficientLength,
  nonNumberInput,
  noError,
  inputDoesntMatch
}

class PinInput extends FormzInput<String, PinInputValidationError> {
  const PinInput.pure({String value = ""}) : super.pure(value);

  const PinInput.dirty({String value = ""}) : super.dirty(value);

  @override
  PinInputValidationError? validator(String value) {
    if (int.tryParse(value) == null) {
      return PinInputValidationError.nonNumberInput;
    } else if (value.length != 6) {
      return PinInputValidationError.insufficientLength;
    } else {
      return null;
    }
  }

  PinInputValidationError? numberValidator() {
    if (int.tryParse(value) == null) {
      return PinInputValidationError.nonNumberInput;
    } else {
      return null;
    }
  }
}
