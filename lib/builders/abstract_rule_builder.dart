import 'package:fluent_validation/fluent_validation.dart';
import 'package:fluent_validation/models/error.dart';

/// Holds a list of rules to match against
class AbstractRuleBuilder<E> {
  AbstractRuleBuilder({
    this.expression,
  });

  /// The expression to get the result for the rule check
  final dynamic Function(E e)? expression;

  /// The list of rules to check against
  final List<ValidationResult Function(dynamic)> rules = <ValidationResult Function(dynamic)>[];

  /// Checks if the object is null
  AbstractRuleBuilder isNull({String? field, String? message}) {
    return must((dynamic dyn) => dyn == null, message ?? "Value must be null", field: field, code: "notNull");
  }

  /// Checks if the object is not null
  AbstractRuleBuilder notNull({String? field, String? message}) {
    return must((dynamic dyn) => dyn != null, message ?? "Value must not be null", field: field, code: "null");
  }

  /// Checks if the object a string and is not empty
  AbstractRuleBuilder notEmpty({String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && dyn.isNotEmpty, message ?? "String must not be empty", field: field, code: "empty");
  }

  /// Checks if the object a string and is empty
  AbstractRuleBuilder empty({String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && dyn.isEmpty, message ?? "String must be empty", field: field, code: "notEmpty");
  }

  /// Checks if the object is not equal to another one
  AbstractRuleBuilder notEqual(dynamic obj, {String? field, String? message}) {
    return must((dynamic dyn) => dyn != obj, message ?? "Value must not be equal", field: field, code: "equal");
  }

  /// Checks if the object is equal to another one
  AbstractRuleBuilder equal(dynamic obj, {String? field, String? message}) {
    return must((dynamic dyn) => dyn == obj, message ?? "Value must be equal", field: field, code: "notEqual");
  }

  /// Checks if the object is a String and is inbetween two lengthes
  AbstractRuleBuilder length(int min, int max, {String? field, String? message}) {
    return must(
        (dynamic dyn) => dyn is String && dyn.length >= min && dyn.length <= max, message ?? "String must between $min and $max characters long",
        field: field, code: "notLength");
  }

  /// Checks if the object is a String and is at least a minimum length
  AbstractRuleBuilder minLength(int min, {String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && dyn.length >= min, message ?? "String must be more than or equal to $min characters long",
        field: field, code: "notMinLength");
  }

  /// Checks if the object is a String and is at below a maximum length
  AbstractRuleBuilder maxLength(int max, {String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && dyn.length <= max, message ?? "String must be less than or equal to $max characters long",
        field: field, code: "notMaxLength");
  }

  /// Checks if the object is a number and is less than another value
  AbstractRuleBuilder lessThan(int min, {String? field, String? message}) {
    return must((dynamic dyn) => dyn is num && dyn < min, message ?? "Number must be less than $min", field: field, code: "notLessThen");
  }

  /// Checks if the object is a number and is less than or equal another value
  AbstractRuleBuilder lessThanOrEqual(int min, {String? field, String? message}) {
    return must((dynamic dyn) => dyn is num && dyn <= min, message ?? "Number must be less than or equal to $min",
        field: field, code: "notLessThanOrEqual");
  }

  /// Checks if the object is a number and is greater than another number
  AbstractRuleBuilder greaterThan(int max, {String? field, String? message}) {
    return must((dynamic dyn) => dyn is num && dyn > max, message ?? "Number must be greater than $max", field: field, code: "notGreaterThan");
  }

  /// Checks if the object is a number and is greater or equal to another number
  AbstractRuleBuilder greaterThanOrEqual(int max, {String? field, String? message}) {
    return must((dynamic dyn) => dyn is num && dyn >= max, message ?? "Number must be greater than or equal to $max",
        field: field, code: "notGreaterThanOrEqual");
  }

  /// Checks the object is a String and is a valid email address
  AbstractRuleBuilder isValidEmailAddress({String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && CommonRegex.emailValidator.hasMatch(dyn), message ?? "String must be a valid email address",
        field: field, code: "notValidEmailAddress");
  }

  /// Checks the object is a String and is a valid phone number
  AbstractRuleBuilder isValidPhoneNumber({String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && CommonRegex.numberValidator.hasMatch(dyn), message ?? "String must be a valid phone number",
        field: field, code: "notValidPhoneNumber");
  }

  /// Checks the object is a String and is a valid UK national insurance number
  AbstractRuleBuilder isValidNationalInsuranceNumber({String? field, String? message}) {
    return must(
        (dynamic dyn) => dyn is String && CommonRegex.ninValidator.hasMatch(dyn), message ?? "String must be a valid national insurance number",
        field: field, code: "notValidNationalInsuranceNumber");
  }

  /// Checks the object is a String and is a valid UK post code
  AbstractRuleBuilder isValidUKPostCode({String? field, String? message}) {
    return must((dynamic dyn) => dyn is String && CommonRegex.postCodeValidator.hasMatch(dyn), message ?? "String must be a valid UK post code",
        field: field, code: "notWalidUKPostCode");
  }

  /// Creates a new rule, passing in an expression and a message and returning a boolean
  AbstractRuleBuilder must(bool Function(dynamic dyn) validator, String? message, {String? field, String? code}) {
    rules.add(
      (dynamic param) => ValidationResult(
        hasError: !validator(param),
        errors: <Error>[Error(name: field, message: message, code: code)],
      ),
    );
    return this;
  }
}
