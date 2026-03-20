import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildRequiredValidator({String? message}) {
  return (String? value) {
    if (isBlank(value)) {
      return message ?? 'This field is required.';
    }

    return null;
  };
}
