import '../typedefs.dart';

ValidatorFunction buildCombinedValidator(List<ValidatorFunction> validators) {
  return (String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }

    return null;
  };
}
