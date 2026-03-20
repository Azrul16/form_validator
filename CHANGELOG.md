# Changelog

All notable changes to this package will be documented in this file.

The format is based on Keep a Changelog, and this project follows semantic versioning.

## 0.0.1

Initial release.

### Added

- `FormValidator` static API for reusable form validation
- `ValidatorFunction` typedef for Flutter form field validators
- Required validator with null, empty, and whitespace checks
- Email validator with optional `allowEmpty`
- Phone validator with optional `allowEmpty`
- Minimum, maximum, and exact length validators
- Password validator with configurable strength rules
- Confirm password validator
- Regex validator for custom pattern matching
- URL validator for `http` and `https` links
- Username validator with optional min and max length
- Numeric validator with optional min and max bounds
- `combine()` helper to chain validators and return the first error
- Custom error message support across validators
- Example Flutter app for manual testing
- Unit test coverage for the package API
