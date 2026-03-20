import 'package:form_validator_kit/form_validator_kit.dart';
import 'package:test/test.dart';

void main() {
  group('combine', () {
    test('returns the first validator error', () {
      final validator = FormValidator.combine([
        FormValidator.required(),
        FormValidator.email(),
      ]);

      expect(validator(''), 'This field is required.');
    });

    test('returns the second validator error when the first passes', () {
      final validator = FormValidator.combine([
        FormValidator.required(),
        FormValidator.email(),
      ]);

      expect(validator('invalid-email'), 'Enter a valid email address.');
    });

    test('returns null when all validators pass', () {
      final validator = FormValidator.combine([
        FormValidator.required(),
        FormValidator.email(),
      ]);

      expect(validator('name@example.com'), isNull);
    });
  });
}
