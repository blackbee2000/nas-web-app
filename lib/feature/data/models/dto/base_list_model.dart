class BaseListModel<T> {
  final List<T>? items;
  final int? pageNumber;
  final int? totalPages;
  final int? totalCount;
  final bool? hasPreviousPage;
  final bool? hasNextPage;

  BaseListModel({
    this.items,
    this.pageNumber,
    this.totalPages,
    this.totalCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });
}
