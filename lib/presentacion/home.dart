import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarea3/aplicacion/riverpod.dart';
import 'package:tarea3/dominio/oferta_auto.dart';
import 'package:tarea3/pages.dart';
import 'package:tarea3/presentacion/card_auto.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerState = ref.watch(containerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Concesionaria Motors', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent.shade200,
      ),
      body: Container(
        color: Colors.red.shade100,
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: containerState.vOfertaAutos.length + 1,
          itemBuilder: (context, index) {
            if (index == containerState.vOfertaAutos.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, Paginas.catalogRoute),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.red
                    ),
                    child: Text(
                      'Catálogo Completo',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              );
            } 
            final OfertaAuto offer = containerState.vOfertaAutos[index];
            return CardAuto(tarjetaAuto: offer, ofertaSpecial: true, textoOferta: 'Oferta Especial!');
          }
        )
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.redAccent.shade200,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/motors-logo.png'),
                  ),
                  currentAccountPictureSize: const Size.square(60.0),
                  accountName: Text('Información Contacto', style: TextStyle(fontSize: 25),),
                  accountEmail: Text('consecionaria.motors@gmail.com', style: TextStyle(fontSize: 17)),
                  decoration: BoxDecoration(
                    color: Colors.black45
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}