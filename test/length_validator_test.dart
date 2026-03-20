import 'package:form_validator/form_validator.dart';
import 'package:test/test.dart';

void main() {
  group('length validators', () {
    test('minLength rejects shorter input', () {
      final validator = FormValidator.minLength(6);

      expect(validator('short'), 'Minimum length is 6 characters.');
    });

    test('minLength accepts exact length', () {
      final validator = FormValidator.minLength(6);

      expect(validator('123456'), isNull);
    });

    test('maxLength rejects longer input', () {
      final validator = FormValidator.maxLength(5);

      expect(validator('123456'), 'Maximum length is 5 characters.');
    });

    test('exactLength enforces exact size', () {
      final validator = FormValidator.exactLength(4);

      expect(validator('123'), 'Length must be exactly 4 characters.');
      expect(validator('1234'), isNull);
    });
  });
}
