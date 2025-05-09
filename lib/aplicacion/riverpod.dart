import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarea3/aplicacion/estados.dart';
import 'package:tarea3/dominio/oferta_auto.dart';

class ContainerNotifier extends StateNotifier<ContainerState> {
  ContainerNotifier() 
    : super(ContainerState(
      vOfertaAutos: listobtenerAutosOferta(),
      vBusquedaOferta: "",
      vListaFiltradaAutos: listaCompletaAutos()
    ));

  void filtrarListaCatalogo(String busqueda) {
    state = state.copyWith(
      vBusquedaOferta: busqueda,
      vListaFiltradaAutos: 
        listaCompletaAutos().where((c) => c.nombre.toLowerCase().contains(busqueda)).toList()
    );
  }
}

final containerProvider = StateNotifierProvider<ContainerNotifier, ContainerState>(
  (ref) => ContainerNotifier()
);

List<OfertaAuto> listobtenerAutosOferta() {
  return [
    OfertaAuto(nombre: 'Tesla Model S', imagenUrl: 'assets/images/tesla-s.png', precio: '\$80,000'),
    OfertaAuto(nombre: 'BMW Serie 3',   imagenUrl: 'assets/images/bmw-3.png',   precio: '\$45,000'),
    OfertaAuto(nombre: 'Audi A4',       imagenUrl: 'assets/images/audi-a4.jpg',  precio: '\$50,000'),
  ];
}

List<OfertaAuto> listaCompletaAutos() {
  return [
    OfertaAuto(nombre: 'Tesla Model S', imagenUrl: 'assets/images/tesla-s.png', precio: '\$80,000'),
    OfertaAuto(nombre: 'BMW Serie 3',   imagenUrl: 'assets/images/bmw-3.png',   precio: '\$45,000'),
    OfertaAuto(nombre: 'Audi A4',       imagenUrl: 'assets/images/audi-a4.jpg',  precio: '\$50,000'),
    OfertaAuto(nombre: 'Tesla Model S', imagenUrl: 'assets/images/tesla-s.png', precio: '\$80,000'),
    OfertaAuto(nombre: 'BMW Serie 3',   imagenUrl: 'assets/images/bmw-3.png',   precio: '\$45,000'),
    OfertaAuto(nombre: 'Audi A4',       imagenUrl: 'assets/images/audi-a4.jpg',  precio: '\$50,000'),
    OfertaAuto(nombre: 'Tesla Model S', imagenUrl: 'assets/images/tesla-s.png', precio: '\$80,000'),
    OfertaAuto(nombre: 'BMW Serie 3',   imagenUrl: 'assets/images/bmw-3.png',   precio: '\$45,000'),
    OfertaAuto(nombre: 'Audi A4',       imagenUrl: 'assets/images/audi-a4.jpg',  precio: '\$50,000'),
    OfertaAuto(nombre: 'Tesla Model S', imagenUrl: 'assets/images/tesla-s.png', precio: '\$80,000'),
    OfertaAuto(nombre: 'BMW Serie 3',   imagenUrl: 'assets/images/bmw-3.png',   precio: '\$45,000'),
    OfertaAuto(nombre: 'Audi A4',       imagenUrl: 'assets/images/audi-a4.jpg',  precio: '\$50,000')
  ];
}