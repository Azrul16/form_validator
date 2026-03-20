import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildRegexValidator(
  Pattern pattern, {
  String? message,
  bool allowEmpty = false,
  bool trim = true,
}) {
  final regex = pattern is RegExp ? pattern : RegExp(pattern.toString());

  return (String? value) {
    final normalized = normalizeValue(value, trim: trim);

    if (normalized == null || normalized.isEmpty) {
      return allowEmpty ? null : (message ?? 'Enter a valid value.');
    }

    if (!regex.hasMatch(normalized)) {
      return message ?? 'Enter a valid value.';
    }

    return null;
  };
}
