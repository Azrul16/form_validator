import '../typedefs.dart';

ValidatorFunction buildConfirmPasswordValidator(
  String originalValue, {
  String? message,
}) {
  return (String? value) {
    if (value != originalValue) {
      return message ?? 'Passwords do not match.';
    }

    return null;
  };
}
