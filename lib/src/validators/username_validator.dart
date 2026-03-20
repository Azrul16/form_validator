import '../patterns.dart';
import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildUsernameValidator({
  String? message,
  int? minLength,
  int? maxLength,
  bool allowEmpty = false,
  bool trim = true,
}) {
  if (minLength != null && minLength < 0) {
    throw ArgumentError.value(minLength, 'minLength', 'Must be 0 or greater.');
  }

  if (maxLength != null && maxLength < 0) {
    throw ArgumentError.value(maxLength, 'maxLength', 'Must be 0 or greater.');
  }

  if (minLength != null && maxLength != null && minLength > maxLength) {
    throw ArgumentError('minLength cannot be greater than maxLength.');
  }

  return (String? value) {
    final normalized = normalizeValue(value, trim: trim);

    if (normalized == null || normalized.isEmpty) {
      return allowEmpty ? null : (message ?? 'Enter a valid username.');
    }

    if (!ValidationPatterns.username.hasMatch(normalized)) {
      return message ??
          'Username can only contain letters, numbers, and underscores.';
    }

    if (minLength != null && normalized.length < minLength) {
      return message ?? 'Username must be at least $minLength characters long.';
    }

    if (maxLength != null && normalized.length > maxLength) {
      return message ?? 'Username must be at most $maxLength characters long.';
    }

    return null;
  };
}
