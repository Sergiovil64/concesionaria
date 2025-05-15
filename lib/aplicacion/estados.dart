

import 'package:tarea3/dominio/auto.dart';

class ContainerState {
  final List<Auto> vListaCompleta;
  final List<Auto> vOfertaAutos;
  final List<Auto> vListaFiltradaAutos;
  final List<Auto> vAutosCarrito;
  String vBusquedaOferta;
  bool loading;
  String modeloAutoIA;
  String precioAutoIA;
  String imagenCamara;

  ContainerState({
    required this. vListaCompleta,
    required this.vOfertaAutos,
    required this.vBusquedaOferta,
    required this.vListaFiltradaAutos,
    required this.vAutosCarrito,
    required this.loading,
    required this.modeloAutoIA,
    required this.precioAutoIA,
    required this.imagenCamara
  });

  ContainerState copyWith({
    List<Auto>? vListaCompleta,
    List<Auto>? vOfertaAutos,
    String? vBusquedaOferta,
    List<Auto>? vListaFiltradaAutos,
    List<Auto>? vAutosCarrito,
    bool? loading,
    String? modeloAutoIA,
    String? precioAutoIA,
    String? imagenCamara
  }) {
    return ContainerState(
      vListaCompleta: vListaCompleta ?? this.vListaCompleta,
      vOfertaAutos: vOfertaAutos ?? this.vOfertaAutos,
      vBusquedaOferta: vBusquedaOferta ?? this.vBusquedaOferta,
      vListaFiltradaAutos: vListaFiltradaAutos ?? this.vListaFiltradaAutos,
      vAutosCarrito: vAutosCarrito ?? this.vAutosCarrito,
      loading: loading ?? this.loading,
      modeloAutoIA: modeloAutoIA ?? this.modeloAutoIA,
      precioAutoIA: precioAutoIA ?? this.precioAutoIA,
      imagenCamara: imagenCamara ?? this.imagenCamara
    );
  }
}