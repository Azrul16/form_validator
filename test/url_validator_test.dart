import 'package:form_validator/form_validator.dart';
import 'package:test/test.dart';

void main() {
  group('url', () {
    test('accepts a valid https url', () {
      final validator = FormValidator.url();

      expect(validator('https://example.com/profile'), isNull);
    });

    test('rejects an invalid url', () {
      final validator = FormValidator.url();

      expect(validator('example'), 'Enter a valid URL.');
    });

    test('accepts empty input when allowEmpty is true', () {
      final validator = FormValidator.url(allowEmpty: true);

      expect(validator(''), isNull);
    });
  });
}
