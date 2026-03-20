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

final class FormValidator {
  const FormValidator._();

  static ValidatorFunction required({String? message}) {
    return buildRequiredValidator(message: message);
  }

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

  static ValidatorFunction minLength(
    int length, {
    String? message,
    bool trim = true,
  }) {
    return buildMinLengthValidator(length, message: message, trim: trim);
  }

  static ValidatorFunction maxLength(
    int length, {
    String? message,
    bool trim = true,
  }) {
    return buildMaxLengthValidator(length, message: message, trim: trim);
  }

  static ValidatorFunction exactLength(
    int length, {
    String? message,
    bool trim = true,
  }) {
    return buildExactLengthValidator(length, message: message, trim: trim);
  }

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

  static ValidatorFunction confirmPassword(
    String originalValue, {
    String? message,
  }) {
    return buildConfirmPasswordValidator(originalValue, message: message);
  }

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

  static ValidatorFunction combine(List<ValidatorFunction> validators) {
    return buildCombinedValidator(validators);
  }
}
