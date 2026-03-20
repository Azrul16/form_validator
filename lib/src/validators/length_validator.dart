import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildMinLengthValidator(
  int length, {
  String? message,
  bool trim = true,
}) {
  if (length < 0) {
    throw ArgumentError.value(length, 'length', 'Must be 0 or greater.');
  }

  return (String? value) {
    final normalized = normalizeValue(value, trim: trim) ?? '';

    if (normalized.length < length) {
      return message ?? 'Minimum length is $length characters.';
    }

    return null;
  };
}

ValidatorFunction buildMaxLengthValidator(
  int length, {
  String? message,
  bool trim = true,
}) {
  if (length < 0) {
    throw ArgumentError.value(length, 'length', 'Must be 0 or greater.');
  }

  return (String? value) {
    final normalized = normalizeValue(value, trim: trim) ?? '';

    if (normalized.length > length) {
      return message ?? 'Maximum length is $length characters.';
    }

    return null;
  };
}

ValidatorFunction buildExactLengthValidator(
  int length, {
  String? message,
  bool trim = true,
}) {
  if (length < 0) {
    throw ArgumentError.value(length, 'length', 'Must be 0 or greater.');
  }

  return (String? value) {
    final normalized = normalizeValue(value, trim: trim) ?? '';

    if (normalized.length != length) {
      return message ?? 'Length must be exactly $length characters.';
    }

    return null;
  };
}
