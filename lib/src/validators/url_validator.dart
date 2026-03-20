import '../typedefs.dart';
import '../utils.dart';

ValidatorFunction buildUrlValidator({
  String? message,
  bool allowEmpty = false,
  bool trim = true,
}) {
  return (String? value) {
    final normalized = normalizeValue(value, trim: trim);

    if (normalized == null || normalized.isEmpty) {
      return allowEmpty ? null : (message ?? 'Enter a valid URL.');
    }

    final uri = Uri.tryParse(normalized);
    final isValid =
        uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        (uri.host.isNotEmpty ||
            normalized.startsWith('http://localhost') ||
            normalized.startsWith('https://localhost'));

    if (!isValid) {
      return message ?? 'Enter a valid URL.';
    }

    return null;
  };
}
