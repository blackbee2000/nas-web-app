class GetListBookingRequest {
  final int pageNumber;
  final int pageSize;
  final String searchText;

  GetListBookingRequest({
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
