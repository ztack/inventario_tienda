// widgets/producto_card.dart

import 'package:flutter/material.dart';

class ProductoCard extends StatelessWidget {
  final String nombre;
  final double precio;
  final int stock;
  final VoidCallback onVender;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const ProductoCard({
    super.key,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.onVender,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    // Determina el color del fondo según el stock
    Color cardColor = Colors.white;
    if (stock == 0) {
      cardColor = Colors.red.shade100;
    } else if (stock <= 5) {
      cardColor = Colors.orange.shade100;
    } else {
      cardColor = Colors.green.shade100.withOpacity(0.2);
    }

    return Card(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre del producto
            Row(
              children: [
                const Icon(Icons.inventory_2, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Precio
            Text(
              'Precio: \$${precio.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),

            // Stock
            Text(
              'Stock: $stock',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),

            const SizedBox(height: 12),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  tooltip: "Vender",
                  onPressed: onVender,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: "Editar",
                  onPressed: onEditar,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: "Eliminar",
                  onPressed: onEliminar,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
