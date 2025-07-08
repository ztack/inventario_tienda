// db/database_provider.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'schema.dart';

class DatabaseProvider {
  static late Database _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    const dbName = "tienda.db";
    final path = join(dbPath, dbName);

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);

    return _database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(ProductoSchema.createTable);
  }
}
