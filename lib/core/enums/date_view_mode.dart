enum DateViewMode {
  date(0, 'Date mode view', 'Chế độ xem ngày'),
  week(1, 'Week mode view', 'Chế độ xem tuần'),
  month(2, 'Month mode view', 'Chế độ xem tháng');

  const DateViewMode(
    this.code,
    this.nameEN,
    this.nameVN,
  );
  final int code;
  final String nameVN;
  final String nameEN;
}
