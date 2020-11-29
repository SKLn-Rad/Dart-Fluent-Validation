import 'package:fluent_validation/fluent_validation.dart';

/// Holds a list of rules to match against
class AbstractRuleBuilder<E> {
  AbstractRuleBuilder({
    this.expression,
  });

  /// The expression to get the result for the rule check
  final dynamic Function(E e) expression;

  /// The list of rules to check against
  final List<ValidationResult Function(dynamic)> rules =
      <ValidationResult Function(dynamic)>[];

  /// Checks if the object is null
  AbstractRuleBuilder isNull({String message}) {
    return must((dynamic dyn) => dyn == null, message ?? "Value must be null");
  }

  /// Checks if the object is not null
  AbstractRuleBuilder notNull({String message}) {
    return must(
        (dynamic dyn) => dyn != null, message ?? "Value must not be null");
  }

  /// Checks if the object a string and is not empty
  AbstractRuleBuilder notEmpty({String message}) {
    return must((dynamic dyn) => dyn is String && dyn.isNotEmpty,
        message ?? "String must not be empty");
  }

  /// Checks if the object a string and is empty
  AbstractRuleBuilder empty({String message}) {
    return must((dynamic dyn) => dyn is String && dyn.isEmpty,
        message ?? "String must be empty");
  }

  /// Checks if the object is not equal to another one
  AbstractRuleBuilder notEqual(dynamic obj, {String message}) {
    return must(
        (dynamic dyn) => dyn != obj, message ?? "Value must not be equal");
  }

  /// Checks if the object is equal to another one
  AbstractRuleBuilder equal(dynamic obj, {String message}) {
    return must((dynamic dyn) => dyn == obj, message ?? "Value must be equal");
  }

  /// Checks if the object is a String and is inbetween two lengthes
  AbstractRuleBuilder length(int min, int max, {String message}) {
    return must(
        (dynamic dyn) =>
            dyn is String && dyn.length >= min && dyn.length <= max,
        message ?? "String must between $min and $max characters long");
  }

  /// Checks if the object is a String and is at least a minimum length
  AbstractRuleBuilder minLength(int min, {String message}) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min,
        message ?? "String must be more than or equal to $min characters long");
  }

  /// Checks if the object is a String and is at below a maximum length
  AbstractRuleBuilder maxLength(int max, {String message}) {
    return must((dynamic dyn) => dyn is String && dyn.length <= max,
        message ?? "String must be less than or equal to $max characters long");
  }

  /// Checks if the object is a number and is less than another value
  AbstractRuleBuilder lessThan(int min, {String message}) {
    return must((dynamic dyn) => dyn is num && dyn < min,
        message ?? "Number must be less than $min");
  }

  /// Checks if the object is a number and is less than or equal another value
  AbstractRuleBuilder lessThanOrEqual(int min, {String message}) {
    return must((dynamic dyn) => dyn is num && dyn <= min,
        message ?? "Number must be less than or equal to $min");
  }

  /// Checks if the object is a number and is greater than another number
  AbstractRuleBuilder greaterThan(int max, {String message}) {
    return must((dynamic dyn) => dyn is num && dyn > max,
        message ?? "Number must be greater than $max");
  }

  /// Checks if the object is a number and is greater or equal to another number
  AbstractRuleBuilder greaterThanOrEqual(int max, {String message}) {
    return must((dynamic dyn) => dyn is num && dyn >= max,
        message ?? "Number must be greater than or equal to $max");
  }

  /// Checks the object is a String and is a valid email address
  AbstractRuleBuilder isValidEmailAddress({String message}) {
    return must(
        (dynamic dyn) =>
            dyn is String && CommonRegex.emailValidator.hasMatch(dyn),
        message ?? "String must be a valid email address");
  }

  /// Checks the object is a String and is a valid phone number
  AbstractRuleBuilder isValidPhoneNumber({String message}) {
    return must(
        (dynamic dyn) =>
            dyn is String && CommonRegex.numberValidator.hasMatch(dyn),
        message ?? "String must be a valid phone number");
  }

  /// Checks the object is a String and is a valid UK national insurance number
  AbstractRuleBuilder isValidNationalInsuranceNumber({String message}) {
    return must(
        (dynamic dyn) =>
            dyn is String && CommonRegex.ninValidator.hasMatch(dyn),
        message ?? "String must be a valid national insurance number");
  }

  /// Checks the object is a String and is a valid UK post code
  AbstractRuleBuilder isValidUKPostCode({String message}) {
    return must(
        (dynamic dyn) =>
            dyn is String && CommonRegex.postCodeValidator.hasMatch(dyn),
        message ?? "String must be a valid UK post code");
  }

  /// Creates a new rule, passing in an expression and a message and returning a boolean
  AbstractRuleBuilder must(
      bool Function(dynamic dyn) validator, String message) {
    rules.add((dynamic param) => ValidationResult(
        hasError: !validator(param), messages: <String>[message]));
    return this;
  }
}
