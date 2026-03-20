import 'package:form_validator/form_validator.dart';
import 'package:test/test.dart';

void main() {
  group('password', () {
    final validator = FormValidator.password(
      minLength: 8,
      requireUppercase: true,
      requireLowercase: true,
      requireNumber: true,
      requireSpecialChar: true,
    );

    test('rejects passwords that are too short', () {
      expect(validator('Aa1!'), 'Password must be at least 8 characters long.');
    });

    test('rejects passwords missing uppercase', () {
      expect(
        validator('password1!'),
        'Password must contain at least one uppercase letter.',
      );
    });

    test('rejects passwords missing lowercase', () {
      expect(
        validator('PASSWORD1!'),
        'Password must contain at least one lowercase letter.',
      );
    });

    test('rejects passwords missing number', () {
      expect(
        validator('Password!'),
        'Password must contain at least one number.',
      );
    });

    test('rejects passwords missing special character', () {
      expect(
        validator('Password1'),
        'Password must contain at least one special character.',
      );
    });

    test('accepts a strong password', () {
      expect(validator('Password1!'), isNull);
    });
  });

  group('confirmPassword', () {
    test('matches the original password', () {
      final validator = FormValidator.confirmPassword('Password1!');

      expect(validator('Password1!'), isNull);
    });

    test('rejects a different password', () {
      final validator = FormValidator.confirmPassword('Password1!');

      expect(validator('Password2!'), 'Passwords do not match.');
    });
  });
}
