import 'package:form_validator_kit/form_validator_kit.dart';
import 'package:test/test.dart';

void main() {
  group('regex', () {
    test('accepts matching input', () {
      final validator = FormValidator.regex(RegExp(r'^[A-Z]{3}\d{3}$'));

      expect(validator('ABC123'), isNull);
    });

    test('rejects non-matching input', () {
      final validator = FormValidator.regex(RegExp(r'^[A-Z]{3}\d{3}$'));

      expect(validator('AB123'), 'Enter a valid value.');
    });

    test('accepts empty input when allowEmpty is true', () {
      final validator = FormValidator.regex(
        RegExp(r'^[A-Z]{3}\d{3}$'),
        allowEmpty: true,
      );

      expect(validator(''), isNull);
    });
  });
}
