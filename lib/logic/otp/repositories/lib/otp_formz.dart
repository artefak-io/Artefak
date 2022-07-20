import 'package:formz/formz.dart';

enum OtpInputValidationError {
  insufficientLength,
  nonNumberInput,
  noError,
  inputDoesntMatch
}

class OtpInput extends FormzInput<String, OtpInputValidationError> {
  const OtpInput.pure({String value = ""}) : super.pure(value);

  const OtpInput.dirty({String value = ""}) : super.dirty(value);

  @override
  OtpInputValidationError? validator(String value) {
    if (int.tryParse(value) == null) {
      return OtpInputValidationError.nonNumberInput;
    } else if (value.length != 6) {
      return OtpInputValidationError.insufficientLength;
    } else {
      return null;
    }
  }

  OtpInputValidationError? numberValidator() {
    if (int.tryParse(value) == null) {
      return OtpInputValidationError.nonNumberInput;
    } else {
      return null;
    }
  }
}
