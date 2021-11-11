import 'dart:convert';

import 'package:fluent_validation/models/error.dart';

/// Returned when validate is called, this holds potential errors with validated objects.

class ValidationResult {
  ValidationResult({
    this.errors = const <Error>[],
    this.hasError = false,
  });

  /// Creates a new validation result to represent an error.
  factory ValidationResult.fromError(String message) {
    return ValidationResult(hasError: true, errors: <Error>[Error(message: message)]);
  }

  /// Merges a collection of validation results together.
  /// Using `ignorePassedMessages` will only keep the messages on failed tests.
  factory ValidationResult.merge(List<ValidationResult> results, bool ignorePassedMessages) {
    return ValidationResult(
      hasError: results.any((ValidationResult result) => result.hasError),
      errors: results.expand((ValidationResult result) => ignorePassedMessages && !result.hasError ? <Error>[] : result.errors).toList(),
    );
  }

  /// Messages which represent the error which can occur
  final List<Error> errors;

  /// Whether the result of this action was an error
  final bool hasError;

  List<Error> getErrorList(String key) {
    return errors.where((element) => element.name == key).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'errors': errors,
        'hasError': hasError,
      };

  factory ValidationResult.fromMap(Map<String, dynamic> map) {
    return ValidationResult(
      errors: List<Error>.from(map['errors']?.map((x) => Error.fromMap(x))),
      hasError: map['hasError'],
    );
  }

  factory ValidationResult.fromJson(String source) => ValidationResult.fromMap(json.decode(source));
}
