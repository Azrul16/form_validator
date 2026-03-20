String? normalizeValue(String? value, {bool trim = true}) {
  if (value == null) {
    return null;
  }

  return trim ? value.trim() : value;
}

bool isBlank(String? value, {bool trim = true}) {
  final normalized = normalizeValue(value, trim: trim);
  return normalized == null || normalized.isEmpty;
}
