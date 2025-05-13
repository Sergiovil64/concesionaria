

import 'package:tarea3/dominio/auto.dart';

class ContainerState {
  final List<Auto> vListaCompleta;
  final List<Auto> vOfertaAutos;
  final List<Auto> vListaFiltradaAutos;
  final List<Auto> vAutosCarrito;
  String vBusquedaOferta;
  bool loading;

  ContainerState({
    required this. vListaCompleta,
    required this.vOfertaAutos,
    required this.vBusquedaOferta,
    required this.vListaFiltradaAutos,
    required this.vAutosCarrito,
    required this.loading
  });

  ContainerState copyWith({
    List<Auto>? vListaCompleta,
    List<Auto>? vOfertaAutos,
    String? vBusquedaOferta,
    List<Auto>? vListaFiltradaAutos,
    List<Auto>? vAutosCarrito,
    bool? loading
  }) {
    return ContainerState(
      vListaCompleta: vListaCompleta ?? this.vListaCompleta,
      vOfertaAutos: vOfertaAutos ?? this.vOfertaAutos,
      vBusquedaOferta: vBusquedaOferta ?? this.vBusquedaOferta,
      vListaFiltradaAutos: vListaFiltradaAutos ?? this.vListaFiltradaAutos,
      vAutosCarrito: vAutosCarrito ?? this.vAutosCarrito,
      loading: loading ?? this.loading
    );
  }
}