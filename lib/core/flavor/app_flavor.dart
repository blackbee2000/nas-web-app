enum Flavor { prod, dev }

class FlavorValue {
  final String baseUrl;

  FlavorValue({required this.baseUrl});
}

class AppFlavor {
  final Flavor flavor;
  final String name;
  final FlavorValue value;

  static AppFlavor? _instance;
  static AppFlavor get instance => _instance!;

  factory AppFlavor({
    required Flavor flavor,
    required String name,
    required FlavorValue value,
  }) {
    _instance = AppFlavor._internal(flavor, name, value);

    return _instance!;
  }

  AppFlavor._internal(this.flavor, this.name, this.value);

  static String get flavorName => AppFlavor.instance.flavor.name;

  static bool get isDev => AppFlavor.instance.flavor == Flavor.dev;

  static bool get isProd => AppFlavor.instance.flavor == Flavor.prod;

  /// Setup development environment
  static void setDevelopmentEnvironment() {
    AppFlavor(
      flavor: Flavor.dev,
      name: "NAS DEV",
      value: FlavorValue(baseUrl: 'http://116.103.229.161'),
    );
  }

  /// Setup production environment
  static void setProductionEnvironment() {
    AppFlavor(
      flavor: Flavor.prod,
      name: "NAS",
      value: FlavorValue(baseUrl: ''),
    );
  }
}
