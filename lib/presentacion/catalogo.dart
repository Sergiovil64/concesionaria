// catalog_page.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tarea3/aplicacion/riverpod.dart';

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
                        final car = containerState.vListaFiltradaAutos[i];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: ListTile(
                            leading: Image.asset(car.imagenUrl, width: 72, fit: BoxFit.cover),
                            title: Text(car.nombre),
                            subtitle: Text(car.precio),
                            trailing: IconButton(
                              icon: Icon(Icons.add_shopping_cart,color: Colors.red),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Se agregó al carrito'),
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            ),
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
