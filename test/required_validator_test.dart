import 'package:form_validator/form_validator.dart';
import 'package:test/test.dart';

void main() {
  group('required', () {
    final validator = FormValidator.required();

    test('returns an error for null', () {
      expect(validator(null), 'This field is required.');
    });

    test('returns an error for empty text', () {
      expect(validator(''), 'This field is required.');
    });

    test('returns an error for whitespace only text', () {
      expect(validator('   '), 'This field is required.');
    });

    test('returns null for a valid value', () {
      expect(validator('Azrul'), isNull);
    });
  });
}
