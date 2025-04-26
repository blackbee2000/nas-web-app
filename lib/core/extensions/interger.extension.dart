extension IntNotNull on int {
  bool toBool() {
    final isFalse = this % 2 == 0;

    return isFalse ? false : true;
  }
}

extension IntNull on int? {
  bool toBool() {
    if (this == null) {
      return false;
    }

    final isFalse = this! % 2 == 0;

    return isFalse ? false : true;
  }
}
