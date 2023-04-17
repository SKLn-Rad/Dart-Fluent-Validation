import 'package:fluent_validation/fluent_validation.dart';

import 'package:test/test.dart';
import 'models/test_user.dart';

void main() {
  test('isNull validator returns errors correctly',
      () => TestUserNullValidator().runTest());
  test('isNotNull validator returns errors correctly',
      () => TestNotNullValidator().runTest());
  test('lessThan validator returns errors correctly',
      () => TestLessThanValidator().runTest());

  test(
      'lessThan validator returns errors correctly with message has name attribute from key',
      () => TestLessThanValidatorMessageHasNameAttributeFromKey().runTest());
}

class TestLessThanValidatorMessageHasNameAttributeFromKey
    extends AbstractValidator<TestUser> {
  void runTest() {
    ruleFor((TestUser user) => user.age, key: 'age', useKeyAsElementName: true)
        .lessThan(15);

    final TestUser testUser = TestUser(age: 18, name: 'Ryan');

    final ValidationResult validationResult = validate(testUser);

    expect(validationResult.hasError, isTrue);
    expect(
        validationResult.errors.first.message
            .contains(validationResult.errors.first.key),
        true);
  }
}

class TestLessThanValidator extends AbstractValidator<TestUser> {
  void runTest() {
    ruleFor((TestUser user) => user.age, key: 'age').lessThan(20);

    final TestUser testUser = TestUser(age: 18, name: 'Ryan');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);

    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.errors.first.key, 'age');
  }
}

class TestNotNullValidator extends AbstractValidator<TestUser> {
  void runTest() {
    ruleFor((TestUser user) => user.age, key: 'age').notNull();

    final TestUser testUser = TestUser(age: null, name: 'Ryan');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isTrue);
    expect(validationResult.errors.first.key, 'age');

    expect(validationResultTwo.hasError, isFalse);
  }
}

class TestUserNullValidator extends AbstractValidator<TestUser> {
  void runTest() {
    ruleFor((TestUser user) => user.age, key: 'age').isNull();

    final TestUser testUser = TestUser(age: null, name: 'Ryan');
    final TestUser testUserTwo = TestUser(age: 24, name: 'Ryan');

    final ValidationResult validationResult = validate(testUser);
    final ValidationResult validationResultTwo = validate(testUserTwo);

    expect(validationResult.hasError, isFalse);

    expect(validationResultTwo.hasError, isTrue);
    expect(validationResultTwo.errors.first.key, 'age');
  }
}
