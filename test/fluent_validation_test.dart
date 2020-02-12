import 'package:fluent_validation/factories/abstract_validator.dart';
import 'package:fluent_validation/models/validation_result.dart';
import 'package:test/test.dart';

import 'models/test_user.dart';

void main() {
  test('isNull validator returns errors correctly', () => TestUserNullValidator().runTest());
  test('isNotNull validator returns errors correctly', () => TestNotNullValidator().runTest());
  test('lessThan validator returns errors correctly', () => TestLessThanValidator().runTest());
}

class TestLessThanValidator extends AbstractValidator<TestUser> {
  TestLessThanValidator() {
    ruleFor((TestUser user) => user.age).lessThan(20);
  }

  void runTest() {
    final TestUser testUser = TestUser(age: 18, name: 'Ryan');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan');
    
    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);
    expect(validationResultTwo.hasError, isTrue);
  }
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