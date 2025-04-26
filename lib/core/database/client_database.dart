class ClientDatabase {
  ClientDatabase._();
  static const String databaseName = 'nas_mobile.db';
  static const int currentVersion = 1;

  static const String tableUsers = 'Users';
  static const String tableNews = 'News';
  static const String tableHistoryBookings = 'HistoryBookings';
  static const String tableStores = 'Stores';
  static const String tableDateTimeBookStores = 'DateTimeBookStores';
  static const String tableTechnicians = 'Technicians';

  /// SQL
  static const String initSql = 'assets/sql/init_db_local.sql';
}
