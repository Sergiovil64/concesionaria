import 'package:flutter/material.dart';
import 'package:tarea3/dominio/auto.dart';

Future<void> verDetalleAuto(BuildContext context, Auto car) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          top: 12,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Image.asset(car.imagenUrl, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 16),

            Text('Modelo: ${car.nombre}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Motor: ${car.motor}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text('Colores: ${car.colores.join(", ")}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text('Medidas: Largo ${car.largo} • Ancho ${car.ancho} • Alto ${car.alto}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Precio: ${car.precio}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Se agregó al carrito', style: TextStyle(color: Colors.white)),
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Agregar a carrito'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}
