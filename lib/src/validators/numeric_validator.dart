import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildNumericValidator({
  String? message,
  bool allowEmpty = false,
  num? min,
  num? max,
  bool trim = true,
}) {
  if (min != null && max != null && min > max) {
    throw ArgumentError('min cannot be greater than max.');
  }

  return (String? value) {
    final normalized = normalizeValue(value, trim: trim);

    if (normalized == null || normalized.isEmpty) {
      return allowEmpty ? null : (message ?? 'Enter a valid number.');
    }

    final parsed = num.tryParse(normalized);
    if (parsed == null) {
      return message ?? 'Enter a valid number.';
    }

    if (min != null && parsed < min) {
      return message ?? 'Enter a number greater than or equal to $min.';
    }

    if (max != null && parsed > max) {
      return message ?? 'Enter a number less than or equal to $max.';
    }

    return null;
  };
}
