class CancelBookingRequest {
  final int id;

  CancelBookingRequest({required this.id});

  Map<String, dynamic> toJson() => {
        "Id": id,
      };
}
