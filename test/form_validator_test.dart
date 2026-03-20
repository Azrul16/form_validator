import 'package:form_validator_kit/form_validator_kit.dart';
import 'package:test/test.dart';

void main() {
  group('username', () {
    test('accepts valid usernames', () {
      final validator = FormValidator.username(minLength: 3, maxLength: 12);

      expect(validator('dev_user1'), isNull);
    });

    test('rejects invalid characters', () {
      final validator = FormValidator.username();

      expect(
        validator('dev-user'),
        'Username can only contain letters, numbers, and underscores.',
      );
    });
  });

  group('numeric', () {
    test('accepts valid numbers in range', () {
      final validator = FormValidator.numeric(min: 18, max: 65);

      expect(validator('30'), isNull);
    });

    test('rejects non-numeric input', () {
      final validator = FormValidator.numeric();

      expect(validator('abc'), 'Enter a valid number.');
    });

    test('rejects out of range values', () {
      final validator = FormValidator.numeric(min: 18, max: 65);

      expect(validator('10'), 'Enter a number greater than or equal to 18.');
      expect(validator('70'), 'Enter a number less than or equal to 65.');
    });
  });
}
