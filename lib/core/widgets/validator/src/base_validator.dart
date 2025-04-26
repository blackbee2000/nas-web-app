part of '../validator.dart';

/// Author: pro100andrey

abstract class Validator<T> {
  const Validator({required this.error});

  /// The error to display when the validation fails
  final String error;

  /// Checks the input against the given conditions
  bool isValid(T value);

  /// Call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error
  String? call(T value) => isValid(value) ? null : error;
}

abstract class TextValidator extends Validator<String?> {
  const TextValidator({
    required String error,
    this.ignoreEmptyValues = true,
  }) : super(error: error);

  // Returns false if you want the validator to return error
  // message when the value is empty.
  final bool ignoreEmptyValues;

  @override
  String? call(String? value) {
    if (value == null) {
      return null;
    }

    return (value.isEmpty && ignoreEmptyValues) ? null : super(value);
  }

  /// Method to check if an input matches a given pattern
  bool hasMatch(
    String pattern,
    String input, {
    bool caseSensitive = true,
  }) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}

/// Group together and validate the basic validators.
class MultiValidator {
  const MultiValidator({required this.validators});

  final List<Validator> validators;

  String? call(String? value) {
    for (final validator in validators) {
      if (validator(value) != null) {
        return validator.error;
      }
    }
    return null;
  }
}

/// Ensures the value is not empty, not white space only.
class RequiredValidator extends TextValidator {
  const RequiredValidator({
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  @override
  bool isValid(String? value) => value != null && value.trim().isNotEmpty;
}
