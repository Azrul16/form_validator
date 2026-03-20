import '../patterns.dart';
import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildEmailValidator({
  String? message,
  bool allowEmpty = false,
  bool trim = true,
}) {
  return (String? value) {
    final normalized = normalizeValue(value, trim: trim);

    if (normalized == null || normalized.isEmpty) {
      return allowEmpty ? null : (message ?? 'Enter a valid email address.');
    }

    if (!ValidationPatterns.email.hasMatch(normalized)) {
      return message ?? 'Enter a valid email address.';
    }

    return null;
  };
}
