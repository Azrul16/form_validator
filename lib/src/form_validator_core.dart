import 'typedefs.dart';
import 'validators/combine_validator.dart';
import 'validators/confirm_password_validator.dart';
import 'validators/email_validator.dart';
import 'validators/length_validator.dart';
import 'validators/numeric_validator.dart';
import 'validators/password_validator.dart';
import 'validators/phone_validator.dart';
import 'validators/regex_validator.dart';
import 'validators/required_validator.dart';
import 'validators/url_validator.dart';
import 'validators/username_validator.dart';

/// Factory methods for building reusable Flutter form field validators.
///
/// Each method returns a [ValidatorFunction] that can be assigned directly to
/// `TextFormField.validator`.
final class FormValidator {
  const FormValidator._();

  /// Validates that a value is not null, empty, or whitespace-only.
  static ValidatorFunction required({String? message}) {
    return buildRequiredValidator(message: message);
  }

  /// Validates email format.
  ///
  /// When [allowEmpty] is `true`, empty values are treated as valid.
  static ValidatorFunction email({
    String? message,
    bool allowEmpty = false,
    bool trim = true,
  }) {
    return buildEmailValidator(
      message: message,
      allowEmpty: allowEmpty,
      trim: trim,
    );
  }

  /// Validates general phone number input.
  ///
  /// When [allowEmpty] is `true`, empty values are treated as valid.
  static ValidatorFunction phone({
    String? message,
    bool allowEmpty = false,
    bool trim = true,
  }) {
    return buildPhoneValidator(
      message: message,
      allowEmpty: allowEmpty,
      trim: trim,
    );
  }

  /// Validates that a value contains at least [length] characters.
  static ValidatorFunction minLength(
    int length, {
    String? message,
    bool trim = true,
  }) {
    return buildMinLengthValidator(length, message: message, trim: trim);
  }

  /// Validates that a value contains no more than [length] characters.
  static ValidatorFunction maxLength(
    int length, {
    String? message,
    bool trim = true,
  }) {
    return buildMaxLengthValidator(length, message: message, trim: trim);
  }

  /// Validates that a value contains exactly [length] characters.
  static ValidatorFunction exactLength(
    int length, {
    String? message,
    bool trim = true,
  }) {
    return buildExactLengthValidator(length, message: message, trim: trim);
  }

  /// Validates a password using configurable strength requirements.
  static ValidatorFunction password({
    String? message,
    int minLength = 8,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireNumber = false,
    bool requireSpecialChar = false,
  }) {
    return buildPasswordValidator(
      message: message,
      minLength: minLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireNumber: requireNumber,
      requireSpecialChar: requireSpecialChar,
    );
  }

  /// Validates that the current value matches [originalValue].
  static ValidatorFunction confirmPassword(
    String originalValue, {
    String? message,
  }) {
    return buildConfirmPasswordValidator(originalValue, message: message);
  }

  /// Validates a value against a custom [pattern].
  ///
  /// When [allowEmpty] is `true`, empty values are treated as valid.
  static ValidatorFunction regex(
    Pattern pattern, {
    String? message,
    bool allowEmpty = false,
    bool trim = true,
  }) {
    return buildRegexValidator(
      pattern,
      message: message,
      allowEmpty: allowEmpty,
      trim: trim,
    );
  }

  /// Validates `http` and `https` URLs.
  ///
  /// When [allowEmpty] is `true`, empty values are treated as valid.
  static ValidatorFunction url({
    String? message,
    bool allowEmpty = false,
    bool trim = true,
  }) {
    return buildUrlValidator(
      message: message,
      allowEmpty: allowEmpty,
      trim: trim,
    );
  }

  /// Validates usernames made of letters, numbers, and underscores.
  ///
  /// Optional [minLength] and [maxLength] constraints can be provided.
  static ValidatorFunction username({
    String? message,
    int? minLength,
    int? maxLength,
    bool allowEmpty = false,
    bool trim = true,
  }) {
    return buildUsernameValidator(
      message: message,
      minLength: minLength,
      maxLength: maxLength,
      allowEmpty: allowEmpty,
      trim: trim,
    );
  }

  /// Validates numeric input with optional [min] and [max] bounds.
  ///
  /// When [allowEmpty] is `true`, empty values are treated as valid.
  static ValidatorFunction numeric({
    String? message,
    bool allowEmpty = false,
    num? min,
    num? max,
    bool trim = true,
  }) {
    return buildNumericValidator(
      message: message,
      allowEmpty: allowEmpty,
      min: min,
      max: max,
      trim: trim,
    );
  }

  /// Runs [validators] in order and returns the first validation error.
  static ValidatorFunction combine(List<ValidatorFunction> validators) {
    return buildCombinedValidator(validators);
  }
}
