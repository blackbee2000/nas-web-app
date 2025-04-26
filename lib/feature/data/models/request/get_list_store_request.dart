class GetListStoreRequest {
  final int pageNumber;
  final int pageSize;
  final String searchText;

  GetListStoreRequest({
    required this.pageNumber,
    required this.pageSize,
    required this.searchText,
  });

  Map<String, dynamic> toJson() => {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
        'SearchText': searchText,
      };
}
