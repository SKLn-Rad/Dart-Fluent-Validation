import '../../lib/factories/abstract_validator.dart';
import '../models/user.dart';

class UserValidator extends AbstractValidator<User> {
  UserValidator() {
    ruleFor((user) => user.age).greaterThan(12);
    ruleFor((user) => user.address).notEmpty();
    ruleFor((user) => user.name).notEmpty();
  }
}