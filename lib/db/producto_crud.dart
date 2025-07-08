// db/producto_crud.dart

import '../db/database_provider.dart';
import '../models/producto.dart';

class ProductoCRUD {
  final DatabaseProvider _provider = DatabaseProvider();

  Future<int> insertProducto(Producto producto) async {
    final db = await _provider.database;
    return await db.insert('productos', producto.toMap());
  }

  Future<List<Producto>> getProductos() async {
    final db = await _provider.database;
    final List<Map<String, dynamic>> maps = await db.query('productos');
    return List.generate(maps.length, (i) => Producto.fromMap(maps[i]));
  }

  Future<int> updateProducto(Producto producto) async {
    final db = await _provider.database;
    return await db.update(
      'productos',
      producto.toMap(),
      where: 'id = ?',
      whereArgs: [producto.id],
    );
  }

  Future<int> deleteProducto(int id) async {
    final db = await _provider.database;
    return await db.delete('productos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> reducirStock(int id, int cantidad) async {
    final db = await _provider.database;
    final producto = await getProductos().then(
      (list) => list.firstWhere((p) => p.id == id),
    );
    if (producto.stock >= cantidad) {
      await db.rawUpdate('''
        UPDATE productos SET stock = stock - $cantidad WHERE id = $id
      ''');
    }
  }
}
