// screens/add_producto_screen.dart

import 'package:flutter/material.dart';
import '../db/producto_crud.dart';
import '../models/producto.dart';

class AddProductoScreen extends StatelessWidget {
  const AddProductoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreCtrl = TextEditingController();
    final TextEditingController precioCtrl = TextEditingController();
    final TextEditingController stockCtrl = TextEditingController();

    final ProductoCRUD productoCRUD = ProductoCRUD();

    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Producto")),
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
                final producto = Producto(
                  nombre: nombreCtrl.text,
                  precio: double.tryParse(precioCtrl.text) ?? 0.0,
                  stock: int.tryParse(stockCtrl.text) ?? 0,
                );
                await productoCRUD.insertProducto(producto);
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
