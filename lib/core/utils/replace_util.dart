class ReplaceUtil {
  ReplaceUtil._();

  /// Replace symbol url
  static String replaceUrlApi({
    required String url,
    required Map<String, dynamic> objectReplace,
  }) {
    objectReplace.forEach((key, value) {
      url = url.replaceAll(key, value);
    });
    return url;
  }
}
