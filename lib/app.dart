import 'package:flutter/material.dart';
import 'package:tarea3/pages.dart';
import 'package:tarea3/presentacion/catalogo.dart';
import 'package:tarea3/presentacion/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concesionaria Motors',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: Paginas.homeRoute,
      routes: {
        Paginas.homeRoute: (_) => const Home(),
        Paginas.catalogRoute: (_) => const Catalogo(),
      },
    );
  }
}
