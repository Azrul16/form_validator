import 'package:form_validator_plus/form_validator_plus.dart';
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
