class CreateBookingRequest {
  final int storeId;
  final int productId;
  final int technicianId;
  final DateTime bookingDate;
  final String bookingTime;
  final String note;
  final String fullName;
  final String address;
  final int gender;
  final String phone;
  final String email;
  final int number;

  CreateBookingRequest({
    required this.storeId,
    required this.productId,
    required this.technicianId,
    required this.bookingDate,
    required this.bookingTime,
    required this.note,
    required this.fullName,
    required this.address,
    required this.gender,
    required this.phone,
    required this.email,
    required this.number,
  });

  Map<String, dynamic> toJson() => {
        "StoreId": storeId,
        "ProductId": productId,
        "TechnicianId": technicianId,
        "BookingDate": bookingDate.toUtc().toIso8601String(),
        "BookingTime": bookingTime,
        "Note": note,
        "FullName": fullName,
        "Address": address,
        "Gender": gender.toInt(),
        "Phone": phone,
        "Email": email,
        "Number": number.toString(),
      };
}
