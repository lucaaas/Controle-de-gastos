abstract class ValidatorInterface {
  static String? validate(String? value, List<ValidatorInterface> validators) {
    String errors = '';
    for(ValidatorInterface validator in validators) {
      errors += validator.isValid(value) ?? '';
    }

    return errors.isNotEmpty? errors : null;
  }

  String? isValid(String? value);
}