# form_validator_plus

A lightweight and composable Flutter form validation package with clean, reusable validators for common form fields.

`form_validator_plus` helps keep validation logic out of your widget tree while still feeling simple to read and easy to customize.

## Features

- Built-in validators for common form use cases
- Composable API with `FormValidator.combine(...)`
- Custom error messages for every validator
- Optional-field support with `allowEmpty`
- Password rule validation with configurable requirements
- Ready to use with `TextFormField.validator`

## Included Validators

- `required`
- `email`
- `phone`
- `minLength`
- `maxLength`
- `exactLength`
- `password`
- `confirmPassword`
- `regex`
- `url`
- `username`
- `numeric`
- `combine`

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  form_validator_plus: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Import

```dart
import 'package:form_validator_plus/form_validator_plus.dart';
```

## Quick Start

```dart
TextFormField(
  decoration: const InputDecoration(labelText: 'Email'),
  validator: FormValidator.combine([
    FormValidator.required(),
    FormValidator.email(),
  ]),
)
```

## Usage Examples

### Required

```dart
TextFormField(
  validator: FormValidator.required(),
)
```

### Email

```dart
TextFormField(
  validator: FormValidator.email(),
)
```

### Optional Email

Useful when a field is optional but still needs to be valid when filled:

```dart
TextFormField(
  validator: FormValidator.email(allowEmpty: true),
)
```

### Combined Validators

```dart
TextFormField(
  validator: FormValidator.combine([
    FormValidator.required(message: 'Email is required'),
    FormValidator.email(),
  ]),
)
```

### Password

```dart
TextFormField(
  obscureText: true,
  validator: FormValidator.password(
    minLength: 8,
    requireUppercase: true,
    requireLowercase: true,
    requireNumber: true,
    requireSpecialChar: true,
  ),
)
```

### Confirm Password

```dart
TextFormField(
  obscureText: true,
  validator: (value) => FormValidator.confirmPassword(
    passwordController.text,
  )(value),
)
```

### Regex

```dart
TextFormField(
  validator: FormValidator.regex(
    RegExp(r'^[A-Z]{3}\d{3}$'),
    message: 'Enter a valid code',
  ),
)
```

### Username

```dart
TextFormField(
  validator: FormValidator.username(
    minLength: 4,
    maxLength: 16,
  ),
)
```

### Numeric Range

```dart
TextFormField(
  validator: FormValidator.numeric(
    min: 18,
    max: 65,
  ),
)
```

### URL

```dart
TextFormField(
  validator: FormValidator.url(allowEmpty: true),
)
```

## API Overview

| Method | Description |
| --- | --- |
| `required({String? message})` | Rejects null, empty, and whitespace-only input. |
| `email({String? message, bool allowEmpty = false, bool trim = true})` | Validates email format. |
| `phone({String? message, bool allowEmpty = false, bool trim = true})` | Validates phone number input. |
| `minLength(int length, {String? message, bool trim = true})` | Enforces a minimum length. |
| `maxLength(int length, {String? message, bool trim = true})` | Enforces a maximum length. |
| `exactLength(int length, {String? message, bool trim = true})` | Enforces an exact length. |
| `password({...})` | Validates password strength rules. |
| `confirmPassword(String originalValue, {String? message})` | Compares the current value against the original password. |
| `regex(Pattern pattern, {String? message, bool allowEmpty = false, bool trim = true})` | Validates a custom pattern. |
| `url({String? message, bool allowEmpty = false, bool trim = true})` | Validates `http` and `https` URLs. |
| `username({String? message, int? minLength, int? maxLength, bool allowEmpty = false, bool trim = true})` | Validates usernames using letters, numbers, and underscores. |
| `numeric({String? message, bool allowEmpty = false, num? min, num? max, bool trim = true})` | Validates numeric input with optional bounds. |
| `combine(List<ValidatorFunction> validators)` | Runs validators in order and returns the first error. |

## Default Error Messages

Examples of the built-in messages:

- `This field is required.`
- `Enter a valid email address.`
- `Enter a valid phone number.`
- `Minimum length is 6 characters.`
- `Maximum length is 20 characters.`
- `Password must contain at least one uppercase letter.`
- `Passwords do not match.`

You can override any of these with a custom `message`.

## Example App

A runnable example app is included in the package:

```bash
cd example
flutter run
```

The example demonstrates:

- single validators
- combined validators
- password rules
- confirm password validation
- optional URL validation

## Testing

This package includes unit tests for:

- required validation
- email validation
- phone validation
- length validation
- password validation
- regex validation
- URL validation
- username validation
- numeric validation
- combined validation

Run tests with:

```bash
dart test
```

## Why Use form_validator_plus

- Reduces repeated validation code across projects
- Keeps widget code easier to read
- Makes validation rules consistent across screens
- Works well for both simple forms and larger production apps

## Roadmap

Planned future improvements may include:

- localization support
- async validators
- date validators
- region-specific validation presets

## License

This package is released under the [MIT License](LICENSE).
