import '../patterns.dart';
import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildPhoneValidator({
  String? message,
  bool allowEmpty = false,
  bool trim = true,
}) {
  return (String? value) {
    final normalized = normalizeValue(value, trim: trim);

    if (normalized == null || normalized.isEmpty) {
      return allowEmpty ? null : (message ?? 'Enter a valid phone number.');
    }

    final digitsOnly = normalized.replaceAll(RegExp(r'\D'), '');
    final isPatternValid = ValidationPatterns.phone.hasMatch(normalized);
    final hasValidLength = digitsOnly.length >= 7 && digitsOnly.length <= 15;

    if (!isPatternValid || !hasValidLength) {
      return message ?? 'Enter a valid phone number.';
    }

    return null;
  };
}
