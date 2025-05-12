

import 'package:tarea3/dominio/auto.dart';

class ContainerState {
  final List<Auto> vOfertaAutos;
  final List<Auto> vListaFiltradaAutos;
  final List<Auto> vAutosCarrito;
  String vBusquedaOferta;

  ContainerState({
    required this.vOfertaAutos,
    required this.vBusquedaOferta,
    required this.vListaFiltradaAutos,
    required this.vAutosCarrito
  });

  ContainerState copyWith({
    List<Auto>? vOfertaAutos,
    String? vBusquedaOferta,
    List<Auto>? vListaFiltradaAutos,
    List<Auto>? vAutosCarrito,
  }) {
    return ContainerState(
      vOfertaAutos: vOfertaAutos ?? this.vOfertaAutos,
      vBusquedaOferta: vBusquedaOferta ?? this.vBusquedaOferta,
      vListaFiltradaAutos: vListaFiltradaAutos ?? this.vListaFiltradaAutos,
      vAutosCarrito: vAutosCarrito ?? this.vAutosCarrito
    );
  }
}