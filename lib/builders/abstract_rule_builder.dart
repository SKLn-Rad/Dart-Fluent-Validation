import 'package:fluent_validation/fluent_validation.dart';

/// Holds a list of rules to match against
class AbstractRuleBuilder<E> {
  AbstractRuleBuilder({
    this.expression,
  });

  /// The expression to get the result for the rule check
  final dynamic Function(E e) expression;

  /// The list of rules to check against
  final List<ValidationResult Function(dynamic)> rules = <ValidationResult Function(dynamic)>[];

  /// Checks if the object is null
  AbstractRuleBuilder isNull() {
    return must((dynamic dyn) => dyn == null, "Value must be null");
  }

  /// Checks if the object is not null
  AbstractRuleBuilder notNull() {
    return must((dynamic dyn) => dyn != null, "Value must not be null");
  }

  /// Checks if the object a string and is not empty
  AbstractRuleBuilder notEmpty() {
    return must((dynamic dyn) => dyn is String && dyn.isNotEmpty, "String must not be empty");
  }

  /// Checks if the object a string and is empty
  AbstractRuleBuilder empty() {
    return must((dynamic dyn) => dyn is String && dyn.isEmpty, "String must be empty");
  }

  /// Checks if the object is not equal to another one
  AbstractRuleBuilder notEqual(dynamic obj) {
    return must((dynamic dyn) => dyn != obj, "Value must not be equal");
  }

  /// Checks if the object is equal to another one
  AbstractRuleBuilder equal(dynamic obj) {
    return must((dynamic dyn) => dyn == obj, "Value must be equal");
  }

  /// Checks if the object is a String and is inbetween two lengthes
  AbstractRuleBuilder length(int min, int max) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min && dyn.length <= max, "String must between $min and $max characters long");
  }

  /// Checks if the object is a String and is at least a minimum length
  AbstractRuleBuilder minLength(int min) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min, "String must be more than or equal to $min characters long");
  }

  /// Checks if the object is a String and is at below a maximum length
  AbstractRuleBuilder maxLength(int max) {
    return must((dynamic dyn) => dyn is String && dyn.length <= max, "String must be less than or equal to $max characters long");
  }

  /// Checks if the object is a number and is less than another value
  AbstractRuleBuilder lessThan(int min) {
    return must((dynamic dyn) => dyn is double && dyn < min, "Number must be less than $min");
  }

  /// Checks if the object is a number and is less than or equal another value
  AbstractRuleBuilder lessThanOrEqual(int min) {
    return must((dynamic dyn) => dyn is double && dyn <= min, "Number must be less than or equal to $min");
  }

  /// Checks if the object is a number and is greater than another number
  AbstractRuleBuilder greaterThan(int max) {
    return must((dynamic dyn) => dyn is double && dyn > max, "Number must be greater than $max");
  }

  /// Checks if the object is a number and is greater or equal to another number
  AbstractRuleBuilder greaterThanOrEqual(int max) {
    return must((dynamic dyn) => dyn is double && dyn >= max, "Number must be greater than or equal to $max");
  }

  /// Checks the object is a String and is a valid email address
  AbstractRuleBuilder isValidEmailAddress() {
    return must((dynamic dyn) => dyn is String && CommonRegex.emailValidator.hasMatch(dyn), "String must be a valid email address");
  }

  /// Checks the object is a String and is a valid phone number
  AbstractRuleBuilder isValidPhoneNumber() {
    return must((dynamic dyn) => dyn is String && CommonRegex.numberValidator.hasMatch(dyn), "String must be a valid phone number");
  }

  /// Checks the object is a String and is a valid UK national insurance number
  AbstractRuleBuilder isValidNationalInsuranceNumber() {
    return must((dynamic dyn) => dyn is String && CommonRegex.ninValidator.hasMatch(dyn), "String must be a valid national insurance number");
  }

  /// Checks the object is a String and is a valid UK post code
  AbstractRuleBuilder isValidUKPostCode() {
    return must((dynamic dyn) => dyn is String && CommonRegex.postCodeValidator.hasMatch(dyn), "String must be a valid UK post code");
  }

  /// Creates a new rule, passing in an expression and a message and returning a boolean
  AbstractRuleBuilder must(bool Function(dynamic dyn) validator, String message) {
    rules.add((dynamic param) => ValidationResult(hasError: !validator(param), messages: <String>[message]));
    return this;
  }
}