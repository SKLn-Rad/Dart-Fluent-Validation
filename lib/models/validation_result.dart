/// Returned when validate is called, this holds potential errors with validated objects.
class ValidationResult {
  ValidationResult({
    this.messages = const <String>[],
    this.hasError = false,
    this.field,
  });

  /// Creates a new validation result to represent an error.
  factory ValidationResult.fromError(String message) {
    return ValidationResult(hasError: true, messages: <String>[message]);
  }

  /// Merges a collection of validation results together.
  /// Using `ignorePassedMessages` will only keep the messages on failed tests.
  factory ValidationResult.merge(List<ValidationResult> results, bool ignorePassedMessages) {
    return ValidationResult(
      hasError: results.any((ValidationResult result) => result.hasError),
      messages: results.expand((ValidationResult result) => ignorePassedMessages && !result.hasError ? <String>[] : result.messages).toList(),
    );
  }

  /// Messages which represent the error which can occur
  final List<String> messages;

  /// Whether the result of this action was an error
  final bool hasError;

  /// Field Name
  final String field;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'field': field,
        'messages': messages,
        'hasError': hasError,
      };
}
