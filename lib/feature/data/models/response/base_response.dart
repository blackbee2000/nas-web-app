class BaseResponse<T> {
  final bool succeeded;
  final String? message;
  final T? data;

  const BaseResponse({
    required this.succeeded,
    this.message,
    this.data,
  });
}
