import 'package:fluent_validation/fluent_validation.dart';
import 'models/user.dart';
import 'validators/user_validator.dart';

void main() {
  final User user = User("Ryan", "Sample Address", 26);
  final UserValidator userValidator = UserValidator();
  final ValidationResult validationResult = userValidator.validate(user);

  if (validationResult.hasError) {
    print('Got an error: $validationResult');
  }

  final User userTwo = User("Ryan", "Sample Address", 11);
  final UserValidator userTwoValidator = UserValidator();
  final ValidationResult validationTwoResult =
      userTwoValidator.validate(userTwo);

  print('First validator results: ${validationResult.errors.length}');
  print('Second validator results: ${validationTwoResult.errors.length}');
}
