// screens/home_screen.dart

import 'package:flutter/material.dart';
import '../db/producto_crud.dart';
import '../models/producto.dart';
import 'add_producto_screen.dart';
import 'edit_producto_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductoCRUD _productoCRUD = ProductoCRUD();
  late Future<List<Producto>> futureProductos;

  @override
  void initState() {
    super.initState();
    futureProductos = _productoCRUD.getProductos();
  }

  void _refreshProductos() {
    setState(() {
      futureProductos = _productoCRUD.getProductos();
    });
  }

  void _navigateToAdd(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProductoScreen()),
    );
    _refreshProductos();
  }

  void _navigateToEdit(BuildContext context, Producto producto) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProductoScreen(producto: producto)),
    );
    _refreshProductos();
  }

  void _showVentaDialog(BuildContext context, Producto producto) {
    int cantidad = 1;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Vender producto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("¿Cuántas unidades de '${producto.nombre}' deseas vender?"),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    cantidad = int.tryParse(value) ?? 1;
                  }
                },
                initialValue: "1",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _productoCRUD.reducirStock(producto.id!, cantidad);
                _refreshProductos();
                Navigator.of(context).pop();
              },
              child: const Text("Vender"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventario Tienda")),
      body: FutureBuilder<List<Producto>>(
        future: futureProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                bool bajoStock = producto.stock <= 5 && producto.stock > 0;
                bool sinStock = producto.stock == 0;

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      "${producto.nombre} - \$${producto.precio.toStringAsFixed(2)}",
                    ),
                    subtitle: Text("Stock: ${producto.stock}"),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        if (!sinStock)
                          IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () =>
                                _showVentaDialog(context, producto),
                          ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _navigateToEdit(context, producto),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _productoCRUD.deleteProducto(producto.id!);
                            _refreshProductos();
                          },
                        ),
                      ],
                    ),
                    tileColor: sinStock
                        ? Colors.red.shade100
                        : bajoStock
                        ? Colors.orange.shade100
                        : null,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
