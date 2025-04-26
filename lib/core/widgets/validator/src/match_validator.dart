part of '../validator.dart';

class MatchValidator extends TextValidator {
  final String Function() valueFirst;
  final String Function() valueSecond;
  MatchValidator({
    required super.error,
    required this.valueFirst,
    required this.valueSecond,
    super.ignoreEmptyValues = false,
  });

  @override
  bool isValid(String? value) {
    String value1 = valueFirst();
    String value2 = valueSecond();

    return value1 == value2;
  }
}
