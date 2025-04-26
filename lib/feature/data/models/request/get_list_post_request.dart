class GetListPostRequest {
  final int pageNumber;
  final int pageSize;

  GetListPostRequest({required this.pageNumber, required this.pageSize});

  Map<String, dynamic> toJson() => {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      };
}
