// catalog_page.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tarea3/aplicacion/riverpod.dart';
import 'package:tarea3/presentacion/ver_detalles.dart';

class Catalogo extends ConsumerWidget {
  const Catalogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerState = ref.watch(containerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catálogo Completo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent.shade200,
      ),
      body: Container(
        color: Colors.red.shade100,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Buscar modelo…',
                  hintStyle: TextStyle(color: Colors.redAccent.shade700),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                ),
                onChanged: (v) => ref.read(containerProvider.notifier).filtrarListaCatalogo(v.toLowerCase()),
              ),
            ),
            Expanded(
              child: containerState.vListaFiltradaAutos.isEmpty
                  ? Center(child: Text('No se encontraron resultados.'))
                  : ListView.builder(
                      itemCount: containerState.vListaFiltradaAutos.length,
                      itemBuilder: (_, i) {
                        final auto = containerState.vListaFiltradaAutos[i];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          color: Colors.white,
                          child: ListTile(
                            leading: Image.asset(auto.imagenUrl, width: 72, fit: BoxFit.cover),
                            title: Text(auto.nombre, style: TextStyle(color: Colors.black),),
                            subtitle: Text(auto.precio, style: TextStyle(color: Colors.black45)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.info, color: Colors.grey),
                                  onPressed: () =>
                                      verDetalleAuto(context, auto),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_shopping_cart,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Agregando al carrito
                                    int agregado = ref.read(containerProvider.notifier).agregarCarrito(auto);
                                    final mensaje = agregado == 0 ? 'Carrito ya añadido previamente' : 'Se agregó al carrito';
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(mensaje, style: TextStyle(color: Colors.white)),
                                        duration: Duration(seconds: 5),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          )
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
