import 'package:fluent_validation/fluent_validation.dart';

abstract class AbstractValidator<E> {
  /// The collection of rule builders
  final List<AbstractRuleBuilder> ruleBuilders = <AbstractRuleBuilder>[];

  /// Creates a new builder to represent a list of rules.
  AbstractRuleBuilder<E> ruleFor(dynamic Function(E e) func) {
    final AbstractRuleBuilder<E> builder =
        AbstractRuleBuilder<E>(expression: func);
    ruleBuilders.add(builder);
    return builder;
  }

  /// Validates an object, returning a merged list of validation result.
  ValidationResult validate(E object, {bool ignorePassedMessages = true}) {
    final List<ValidationResult> results = <ValidationResult>[];
    for (final AbstractRuleBuilder<E> ruleBuilder in ruleBuilders) {
      final dynamic expressedValue = ruleBuilder.expression(object);
      for (final ValidationResult Function(dynamic) rule in ruleBuilder.rules) {
        final ValidationResult result = rule(expressedValue);
        results.add(result);
      }
    }

    return ValidationResult.merge(results, ignorePassedMessages);
  }
}