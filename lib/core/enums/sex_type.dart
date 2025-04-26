enum SexType {
  male(1, 'Nam'),
  female(2, 'Nữ'),
  other(3, 'Khác');

  const SexType(
    this.code,
    this.name,
  );
  final int code;
  final String name;

  static SexType? mapping(int code) {
    switch (code) {
      case 1:
        return SexType.male;
      case 2:
        return SexType.female;
      case 3:
        return SexType.other;
      default:
        return null;
    }
  }
}
