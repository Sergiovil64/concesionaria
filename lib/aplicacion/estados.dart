

import 'package:tarea3/dominio/oferta_auto.dart';

class ContainerState {
  final List<OfertaAuto> vOfertaAutos;

  ContainerState({
    required this.vOfertaAutos
  });

  ContainerState copyWith({
    List<OfertaAuto>? vOfertaAutos    
  }) {
    return ContainerState(
          vOfertaAutos: vOfertaAutos ?? this.vOfertaAutos
    );
  }
}