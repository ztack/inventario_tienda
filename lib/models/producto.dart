// models/producto.dart

class Producto {
  final int? id;
  final String nombre;
  final double precio;
  int stock;

  Producto({
    this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'precio': precio, 'stock': stock};
  }

  Producto copyWith({int? id, String? nombre, double? precio, int? stock}) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      stock: stock ?? this.stock,
    );
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      precio: map['precio'] is int ? map['precio'].toDouble() : map['precio'],
      stock: map['stock'],
    );
  }
}
