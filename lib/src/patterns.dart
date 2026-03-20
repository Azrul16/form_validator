final class ValidationPatterns {
  static final RegExp email = RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
    caseSensitive: false,
  );

  static final RegExp phone = RegExp(r'^\+?[0-9().\s-]{7,20}$');

  static final RegExp username = RegExp(r'^[A-Za-z0-9_]+$');

  static final RegExp uppercase = RegExp(r'[A-Z]');

  static final RegExp lowercase = RegExp(r'[a-z]');

  static final RegExp number = RegExp(r'\d');

  static final RegExp specialCharacter = RegExp(
    r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]+=~`]',
  );
}
