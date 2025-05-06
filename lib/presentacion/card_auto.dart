import 'package:flutter/material.dart';
import 'package:tarea3/dominio/oferta_auto.dart';
import 'package:tarea3/presentacion/animated_sticker.dart';

class CardAuto extends StatelessWidget {
  final OfertaAuto tarjetaAuto;
  final bool ofertaSpecial;
  final String textoOferta;

  const CardAuto({
    super.key, 
    required this.tarjetaAuto,
    this.ofertaSpecial = false,
    this.textoOferta = ''
  });


  @override
  Widget build(BuildContext context) {
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
                      // Aquí iría la lógica para ver detalles o comprar
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