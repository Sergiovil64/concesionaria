

import 'package:tarea3/dominio/oferta_auto.dart';

class ContainerState {
  final List<OfertaAuto> vOfertaAutos;
  final List<OfertaAuto> vListaFiltradaAutos;
  String vBusquedaOferta;

  ContainerState({
    required this.vOfertaAutos,
    required this.vBusquedaOferta,
    required this.vListaFiltradaAutos
  });

  ContainerState copyWith({
    List<OfertaAuto>? vOfertaAutos,
    String? vBusquedaOferta,
    List<OfertaAuto>? vListaFiltradaAutos,
  }) {
    return ContainerState(
          vOfertaAutos: vOfertaAutos ?? this.vOfertaAutos,
          vBusquedaOferta: vBusquedaOferta ?? this.vBusquedaOferta,
          vListaFiltradaAutos: vListaFiltradaAutos ?? this.vListaFiltradaAutos
    );
  }
}