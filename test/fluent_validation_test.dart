import 'package:fluent_validation/factories/abstract_validator.dart';
import 'package:fluent_validation/models/validation_result.dart';
import 'package:test/test.dart';

import 'models/test_user.dart';

void main() {
  test('isNull validator only errors when not null', () => TestUserNullValidator().runTest());
  test('isNotNull validator only errors when null', () => TestNotNullValidator().runTest());
}

class TestNotNullValidator extends AbstractValidator<TestUser> {
  TestUserNullValidator() {
    ruleFor((TestUser user) => user.age).notNull();
  }

  void runTest() {
    final TestUser testUser = TestUser(age: null, name: 'Ryan');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan');
    
    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isTrue);
    expect(validationResultTwo.hasError, isFalse);
  }
}

class TestUserNullValidator extends AbstractValidator<TestUser> {
  TestUserNullValidator() {
    ruleFor((TestUser user) => user.age).isNull();
  }

  void runTest() {
    final TestUser testUser = TestUser(age: null, name: 'Ryan');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan');
    
    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
  }
}