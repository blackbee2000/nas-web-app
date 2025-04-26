part of '../validator.dart';

/// Ensures the value length contains no more than a set number of characters.
class MaxLengthValidator extends TextValidator {
  const MaxLengthValidator({
    required this.max,
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  final int max;

  @override
  bool isValid(String? value) => value!.length <= max;
}

/// Ensures the value length contains no fewer than a set number of characters.
class MinLengthValidator extends TextValidator {
  const MinLengthValidator({
    required this.min,
    required String error,
    bool ignoreEmptyValues = true,
  }) : super(error: error, ignoreEmptyValues: ignoreEmptyValues);

  final int min;

  @override
  bool isValid(String? value) => value!.length >= min;
}
