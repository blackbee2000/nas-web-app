part of '../validator.dart';

class MinValueValidator extends TextValidator {
  final int maxValue;
  final bool containEqual;

  MinValueValidator(
      {required String errorText,
      bool ignoreEmptyValues = true,
      required this.maxValue,
      this.containEqual = false})
      : super(error: errorText, ignoreEmptyValues: ignoreEmptyValues);

  @override
  bool isValid(String? value) {
    String normalizeNumber = value!.replaceAll(RegExp(r'[^0-9]'), '');
    int? number = int.tryParse(normalizeNumber);
    if (number == null) {
      return false;
    }
    if (containEqual) {
      return number <= maxValue;
    } else {
      return number < maxValue;
    }
  }
}

class MaxValueValidator extends TextValidator {
  final int maxValue;
  final bool containEqual;

  MaxValueValidator(
      {required String errorText,
      bool ignoreEmptyValues = true,
      required this.maxValue,
      this.containEqual = false})
      : super(error: errorText, ignoreEmptyValues: ignoreEmptyValues);

  @override
  bool isValid(String? value) {
    String normalizeNumber = value!.replaceAll(RegExp(r'[^0-9]'), '');
    int? number = int.tryParse(normalizeNumber);
    if (number == null) {
      return false;
    }
    if (containEqual) {
      return number <= maxValue;
    } else {
      return number < maxValue;
    }
  }
}
