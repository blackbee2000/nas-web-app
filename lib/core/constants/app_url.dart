class AppUrl {
  AppUrl._();

  /// Common
  static const String _openApiVN = 'https://provinces.open-api.vn/api';
  static const String province = '$_openApiVN/p';
  static const String district = '$_openApiVN/p/{provinceCode}?depth=2';
  static const String ward = '$_openApiVN/d/{districtCode}?depth=2';

  /// Url extenal application
  static const String smsApp = 'sms:{phoneNumber}';
  static const String whatsApp = 'https://wa.me/{phoneNumber}';
  static const String telegramApp = 'https://t.me/{phoneNumber}';
  static const String messagerApp = 'https://m.me/{userId}';
  static const String zaloApp = 'https://zalo.me/{phoneNumber}';

  ///
  static const List<String> groupIdList = [
    '1258b3cc-01ad-45a3-a6ec-79e19f14e2cf'
  ];

  /// Api
  /// User
  static const String _user = '/user/api/v1/appaccounts';
  static const String login = '$_user/login';
  static const String register = '$_user/regiter';
  static const String updateUser = '$_user/{id}';
  static const String profile = '$_user/profile';
  static const String changePassword = '$_user/change-password';
  static const String forgetPassword = '$_user/forgot-password';
  static const String resetPassword = '$_user/reset-password';

  /// Post
  static const String _post = '/article/api/v1/posts';
  static const String postList = '$_post/pagingation';
  static const String postDetail = '$_post/{id}';
  static const String likePost = '$_post/update-favorite/{id}';

  /// Store
  static const String _store = '/catalog/api/v1/stores';
  static const String storeList = '$_store/pagingation';
  static const String storeDetail = '$_store/{id}';
  static const String likeStore = '$_store/update-favorite/{id}';

  /// Technicians
  static const String _technician = '/user/api/v1/technicians';
  static const String technicianList = '$_technician/pagingation-mobile';

  /// Booking
  static const String _booking = '/order/api/v1/bookings';
  static const String bookingCreate = '$_booking/create';
  static const String bookingList = '$_booking/me';
  static const String bookingDetail = '$_booking/{id}';
  static const String cancelBooking = '$_booking/cancel-mobile/{id}';

  /// Banner
  static const String _banner = '/catalog/api/v1/banners';
  static const String bannerList = '$_banner/pagingation';
}
