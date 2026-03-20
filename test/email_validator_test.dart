import 'package:form_validator_plus/form_validator_plus.dart';
import 'package:test/test.dart';

void main() {
  group('email', () {
    test('accepts a valid email', () {
      final validator = FormValidator.email();

      expect(validator('name@example.com'), isNull);
    });

    test('rejects an invalid email', () {
      final validator = FormValidator.email();

      expect(validator('name@example'), 'Enter a valid email address.');
    });

    test('rejects empty input when allowEmpty is false', () {
      final validator = FormValidator.email();

      expect(validator(''), 'Enter a valid email address.');
    });

    test('accepts empty input when allowEmpty is true', () {
      final validator = FormValidator.email(allowEmpty: true);

      expect(validator(''), isNull);
    });
  });
}
