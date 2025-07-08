// screens/edit_producto_screen.dart

import 'package:flutter/material.dart';
import '../db/producto_crud.dart';
import '../models/producto.dart';

class EditProductoScreen extends StatelessWidget {
  final Producto producto;

  const EditProductoScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreCtrl = TextEditingController(
      text: producto.nombre,
    );
    final TextEditingController precioCtrl = TextEditingController(
      text: producto.precio.toString(),
    );
    final TextEditingController stockCtrl = TextEditingController(
      text: producto.stock.toString(),
    );

    final ProductoCRUD productoCRUD = ProductoCRUD();

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Producto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: precioCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Precio"),
            ),
            TextField(
              controller: stockCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Stock"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updated = producto.copyWith(
                  nombre: nombreCtrl.text,
                  precio: double.tryParse(precioCtrl.text) ?? 0.0,
                  stock: int.tryParse(stockCtrl.text) ?? 0,
                );
                await productoCRUD.updateProducto(updated);
                Navigator.pop(context);
              },
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
