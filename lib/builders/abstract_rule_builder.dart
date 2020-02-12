import 'package:fluent_validation/fluent_validation.dart';

class AbstractRuleBuilder<E> {
  AbstractRuleBuilder({
    this.expression,
  });

  final dynamic Function(E e) expression;
  final List<ValidationResult Function(dynamic)> rules = <ValidationResult Function(dynamic)>[];

  AbstractRuleBuilder isNull() {
    return must((dynamic dyn) => dyn == null, "Value must be null");
  }

  AbstractRuleBuilder isNotNull() {
    return must((dynamic dyn) => dyn != null, "Value must not be null");
  }

  AbstractRuleBuilder notEmpty() {
    return must((dynamic dyn) => dyn is String && !dyn.isEmpty, "String must not be empty");
  }

  AbstractRuleBuilder empty() {
    return must((dynamic dyn) => dyn is String && dyn.isEmpty, "String must be empty");
  }

  AbstractRuleBuilder notEqual(dynamic obj) {
    return must((dynamic dyn) => dyn != obj, "Value must not be equal");
  }

  AbstractRuleBuilder equal(dynamic obj) {
    return must((dynamic dyn) => dyn == obj, "Value must be equal");
  }

  AbstractRuleBuilder length(int min, int max) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min && dyn.length <= max, "String must between $min and $max characters long");
  }

  AbstractRuleBuilder minLength(int min) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min, "String must be more than or equal to $min characters long");
  }

  AbstractRuleBuilder maxLength(int max) {
    return must((dynamic dyn) => dyn is String && dyn.length <= max, "String must be less than or equal to $max characters long");
  }

  AbstractRuleBuilder lessThan(int min) {
    return must((dynamic dyn) => dyn is double && dyn < min, "Number must be less than $min");
  }

  AbstractRuleBuilder lessThanOrEqual(int min) {
    return must((dynamic dyn) => dyn is double && dyn <= min, "Number must be less than or equal to $min");
  }

  AbstractRuleBuilder greaterThan(int max) {
    return must((dynamic dyn) => dyn is double && dyn > max, "Number must be greater than $max");
  }

  AbstractRuleBuilder greaterThanOrEqual(int max) {
    return must((dynamic dyn) => dyn is double && dyn >= max, "Number must be greater than or equal to $max");
  }

  AbstractRuleBuilder isValidEmailAddress() {
    return must((dynamic dyn) => dyn is String && CommonRegex.emailValidator.hasMatch(dyn), "String must be a valid email address");
  }

  AbstractRuleBuilder isValidPhoneNumber() {
    return must((dynamic dyn) => dyn is String && CommonRegex.numberValidator.hasMatch(dyn), "String must be a valid phone number");
  }

  AbstractRuleBuilder isValidNationalInsuranceNumber() {
    return must((dynamic dyn) => dyn is String && CommonRegex.ninValidator.hasMatch(dyn), "String must be a valid national insurance number");
  }

  AbstractRuleBuilder isValidUKPostCode() {
    return must((dynamic dyn) => dyn is String && CommonRegex.postCodeValidator.hasMatch(dyn), "String must be a valid UK post code");
  }

  AbstractRuleBuilder must(bool Function(dynamic dyn) validator, String message) {
    rules.add((dynamic param) => ValidationResult(isError: !validator(param), messages: <String>[message]));
    return this;
  }
}