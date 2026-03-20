/// Signature used by Flutter form field validators.
///
/// Returns `null` when the value is valid, otherwise returns an error message.
typedef ValidatorFunction = String? Function(String? value);
