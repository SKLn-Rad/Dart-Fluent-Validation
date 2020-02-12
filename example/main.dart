import 'package:fluent_validation/fluent_validation.dart';
import 'models/user.dart';
import 'validators/user_validator.dart';

void main() {
  final User user = User("Ryan", "Sample Address", 26);
  final UserValidator userValidator = UserValidator();
  final ValidationResult validationResult = userValidator.validate(user);
  if (validationResult.hasError) {
    // Handle Error
  }
}