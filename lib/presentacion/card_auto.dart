import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarea3/aplicacion/riverpod.dart';
import 'package:tarea3/dominio/auto.dart';
import 'package:tarea3/presentacion/animated_sticker.dart';
import 'package:tarea3/presentacion/ver_detalles.dart';

class CardAuto extends ConsumerWidget {
  final Auto tarjetaAuto;
  final bool ofertaSpecial;
  final String textoOferta;

  const CardAuto({
    super.key, 
    required this.tarjetaAuto,
    this.ofertaSpecial = false,
    this.textoOferta = ''
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  tarjetaAuto.imagenUrl,
                  height: 180,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: ofertaSpecial ? AnimatedSticker(texto: textoOferta,) : SizedBox(),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                    child: Icon(Icons.add_shopping_cart, color: Colors.red.shade400, shadows: [Shadow(color: Colors.black, offset: Offset(0.3, 0.3))],)
                  ),
                  onTap: () {
                    // Agregando al carrito
                    int agregado = ref.read(containerProvider.notifier).agregarCarrito(tarjetaAuto);
                    final mensaje = agregado == 0 ? 'Carrito ya añadido previamente' : 'Se agregó al carrito';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(mensaje),
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tarjetaAuto.nombre,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Precio: ${tarjetaAuto.precio}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      verDetalleAuto(context, tarjetaAuto);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red
                    ),
                    child: Text('Ver Detalles', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}