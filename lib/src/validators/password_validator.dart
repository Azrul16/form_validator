import '../patterns.dart';
import '../typedefs.dart';

ValidatorFunction buildPasswordValidator({
  String? message,
  int minLength = 8,
  bool requireUppercase = false,
  bool requireLowercase = false,
  bool requireNumber = false,
  bool requireSpecialChar = false,
}) {
  if (minLength < 0) {
    throw ArgumentError.value(minLength, 'minLength', 'Must be 0 or greater.');
  }

  return (String? value) {
    final currentValue = value ?? '';

    if (currentValue.length < minLength) {
      return message ?? 'Password must be at least $minLength characters long.';
    }

    if (requireUppercase &&
        !ValidationPatterns.uppercase.hasMatch(currentValue)) {
      return message ?? 'Password must contain at least one uppercase letter.';
    }

    if (requireLowercase &&
        !ValidationPatterns.lowercase.hasMatch(currentValue)) {
      return message ?? 'Password must contain at least one lowercase letter.';
    }

    if (requireNumber && !ValidationPatterns.number.hasMatch(currentValue)) {
      return message ?? 'Password must contain at least one number.';
    }

    if (requireSpecialChar &&
        !ValidationPatterns.specialCharacter.hasMatch(currentValue)) {
      return message ?? 'Password must contain at least one special character.';
    }

    return null;
  };
}
