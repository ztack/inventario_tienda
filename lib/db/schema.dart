// db/schema.dart

class ProductoSchema {
  static const String tableName = "productos";

  static const String columnId = "id";
  static const String columnNombre = "nombre";
  static const String columnPrecio = "precio";
  static const String columnStock = "stock";

  static String createTable =
      '''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnNombre TEXT NOT NULL,
      $columnPrecio REAL NOT NULL,
      $columnStock INTEGER NOT NULL DEFAULT 0
    )
  ''';
}
