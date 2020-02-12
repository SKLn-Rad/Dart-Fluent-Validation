class ValidationResult {
  ValidationResult({
    this.messages = const <String>[],
    this.isError = false,
  });

  factory ValidationResult.fromError(String message) {
    return ValidationResult(isError: true, messages: <String>[message]);
  }

  factory ValidationResult.merge(List<ValidationResult> results, bool ignorePassedMessages) {
    return ValidationResult(
      isError: results.any((ValidationResult result) => result.isError),
      messages: results.expand((ValidationResult result) => ignorePassedMessages && !result.isError ? <String>[] : result.messages).toList(),
    );
  }

  final List<String> messages;
  final bool isError;
}
