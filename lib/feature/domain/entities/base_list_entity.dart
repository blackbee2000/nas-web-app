class BaseListEntity<T> {
  final List<T> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  BaseListEntity({
    required this.items,
    this.pageNumber = 0,
    this.totalPages = 0,
    this.totalCount = 0,
    this.hasPreviousPage = false,
    this.hasNextPage = false,
  });
}
