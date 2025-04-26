enum NewsType {
  all('all', 'Tất cả'),
  hot('hot', 'Nổi bật'),
  favorite('favorite', 'Yêu thích');

  const NewsType(
    this.code,
    this.name,
  );
  final String code;
  final String name;
}
