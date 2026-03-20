import 'package:form_validator_plus/form_validator_plus.dart';
import 'package:test/test.dart';

void main() {
  group('phone', () {
    test('accepts a valid international number', () {
      final validator = FormValidator.phone();

      expect(validator('+1 202-555-0125'), isNull);
    });

    test('rejects input with too few digits', () {
      final validator = FormValidator.phone();

      expect(validator('12345'), 'Enter a valid phone number.');
    });

    test('accepts empty input when allowEmpty is true', () {
      final validator = FormValidator.phone(allowEmpty: true);

      expect(validator(''), isNull);
    });
  });
}
