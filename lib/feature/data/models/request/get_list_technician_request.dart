class GetListTechnicianRequest {
  final int pageNumber;
  final int pageSize;
  final String searchText;
  final int? storeId;

  GetListTechnicianRequest({
    required this.pageNumber,
    required this.pageSize,
    required this.searchText,
    required this.storeId,
  });

  Map<String, dynamic> toJson() => {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
        'SearchText': searchText,
        'storeId': storeId,
      };
}
