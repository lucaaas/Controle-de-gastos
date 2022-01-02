import 'package:controlegastos/app/core/validators/validator_interface.dart';

class RequiredValidator extends ValidatorInterface {
  @override
  String? isValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório \n';
    }
  }
}