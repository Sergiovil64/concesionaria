import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarea3/aplicacion/estados.dart';
import 'package:tarea3/data/db_auto.dart';
import 'package:tarea3/dominio/auto.dart';

class ContainerNotifier extends StateNotifier<ContainerState> {
  ContainerNotifier() 
    : super(ContainerState(
      vListaCompleta: [],
      vOfertaAutos: [],
      vBusquedaOferta: "",
      vListaFiltradaAutos: listaCompletaAutos(),
      vAutosCarrito: [],
      loading: true
    ));

  void agregarCarrito(Auto auto) {
    print('Entrando...');
    state = state.copyWith(vAutosCarrito: [...state.vAutosCarrito, auto]);
  }

  Future<void> filtrarListaCatalogo(String busqueda) async {
    state = state.copyWith(
      vBusquedaOferta: busqueda,
      vListaFiltradaAutos: 
        state.vListaCompleta.where((c) => c.nombre.toLowerCase().contains(busqueda)).toList()
    );
  }

  Future<List<Auto>> insertarAutos() async {
    final db = DBAuto();
    final existenAutos = await db.getAllCars();
    if (existenAutos.isEmpty) {
      final autos = listaCompletaAutos();
      for(final auto in autos) {
        await db.insertCar(auto);
      }
    }
    final listaFinal = await db.getAllCars();
    final List<Auto> autosEnOferta = (listaFinal.where((auto) => auto.enOferta)).toList();
    state = state.copyWith(vListaCompleta: listaFinal, loading: false, vOfertaAutos: autosEnOferta);
    return listaFinal;
  }
}

final containerProvider = StateNotifierProvider<ContainerNotifier, ContainerState>(
  (ref) => ContainerNotifier()
);

List<Auto> listaCompletaAutos() {
  return [
    Auto(
      nombre: 'Tesla Model S',
      imagenUrl: 'assets/images/tesla-s.png',
      precio: '\$80,000',
      motor: 'Electric Dual Motor',
      alto: '1.44 m',
      ancho: '1.96 m',
      largo: '4.97 m',
      enOferta: true,
      colores: ['Negro', 'Blanco', 'Rojo'],
    ),
    Auto(
      nombre: 'Tesla Model 3',
      imagenUrl: 'assets/images/tesla-3.jpeg',
      precio: '\$40,000',
      motor: 'Electric Single Motor',
      alto: '1.44 m',
      ancho: '1.85 m',
      largo: '4.69 m',
      enOferta: false,
      colores: ['Blanco', 'Negro', 'Azul'],
    ),
    Auto(
      nombre: 'Tesla Model X',
      imagenUrl: 'assets/images/tesla-x.jpg',
      precio: '\$90,000',
      motor: 'Electric Tri Motor',
      alto: '1.68 m',
      ancho: '2.07 m',
      largo: '5.04 m',
      enOferta: true,
      colores: ['Blanco', 'Gris', 'Negro'],
    ),
    Auto(
      nombre: 'Tesla Model Y',
      imagenUrl: 'assets/images/tesla-y.jpeg',
      precio: '\$50,000',
      motor: 'Electric Dual Motor',
      alto: '1.62 m',
      ancho: '1.92 m',
      largo: '4.75 m',
      enOferta: false,
      colores: ['Blanco', 'Negro', 'Rojo'],
    ),
    Auto(
      nombre: 'Ford Mustang',
      imagenUrl: 'assets/images/ford-mustang.jpeg',
      precio: '\$55,000',
      motor: '5.0L V8',
      alto: '1.38 m',
      ancho: '1.91 m',
      largo: '4.78 m',
      enOferta: false,
      colores: ['Rojo', 'Negro', 'Amarillo'],
    ),
    Auto(
      nombre: 'Chevrolet Camaro',
      imagenUrl: 'assets/images/chevrolet-camaro.jpeg',
      precio: '\$45,000',
      motor: '3.6L V6',
      alto: '1.34 m',
      ancho: '1.90 m',
      largo: '4.78 m',
      enOferta: false,
      colores: ['Azul', 'Negro', 'Blanco'],
    ),
    Auto(
      nombre: 'BMW Serie 3',
      imagenUrl: 'assets/images/bmw-3.png',
      precio: '\$42,000',
      motor: '2.0L Turbo Inline-4',
      alto: '1.44 m',
      ancho: '1.83 m',
      largo: '4.71 m',
      enOferta: true,
      colores: ['Blanco', 'Negro', 'Gris'],
    ),
    Auto(
      nombre: 'BMW Serie 5',
      imagenUrl: 'assets/images/bmw-5.jpeg',
      precio: '\$55,000',
      motor: '3.0L Turbo Inline-6',
      alto: '1.48 m',
      ancho: '1.87 m',
      largo: '4.94 m',
      enOferta: false,
      colores: ['Blanco', 'Azul', 'Negro'],
    ),
    Auto(
      nombre: 'Audi A4',
      imagenUrl: 'assets/images/audi-a4.jpg',
      precio: '\$50,000',
      motor: '2.0L Turbo Inline-4',
      alto: '1.42 m',
      ancho: '1.84 m',
      largo: '4.73 m',
      enOferta: true,
      colores: ['Gris', 'Negro', 'Blanco'],
    ),
    Auto(
      nombre: 'Audi Q5',
      imagenUrl: 'assets/images/audi-q5.jpeg',
      precio: '\$52,000',
      motor: '2.0L Turbo Inline-4',
      alto: '1.66 m',
      ancho: '1.89 m',
      largo: '4.66 m',
      enOferta: false,
      colores: ['Negro', 'Blanco', 'Rojo'],
    ),
    Auto(
      nombre: 'Mercedes C-Class',
      imagenUrl: 'assets/images/mercedes-c.jpg',
      precio: '\$48,000',
      motor: '2.0L Turbo Inline-4',
      alto: '1.44 m',
      ancho: '1.81 m',
      largo: '4.69 m',
      enOferta: false,
      colores: ['Negro', 'Blanco', 'Plateado'],
    ),
    Auto(
      nombre: 'Mercedes E-Class',
      imagenUrl: 'assets/images/mercedes-e.jpeg',
      precio: '\$60,000',
      motor: '3.0L Turbo Inline-6',
      alto: '1.46 m',
      ancho: '1.85 m',
      largo: '4.92 m',
      enOferta: false,
      colores: ['Blanco', 'Negro', 'Azul'],
    ),
    Auto(
      nombre: 'Toyota Camry',
      imagenUrl: 'assets/images/toyota-camry.jpg',
      precio: '\$25,000',
      motor: '2.5L Inline-4',
      alto: '1.44 m',
      ancho: '1.84 m',
      largo: '4.88 m',
      enOferta: false,
      colores: ['Blanco', 'Negro', 'Gris'],
    ),
    Auto(
      nombre: 'Honda Civic',
      imagenUrl: 'assets/images/honda-civic.jpg',
      precio: '\$22,000',
      motor: '2.0L Turbo Inline-4',
      alto: '1.41 m',
      ancho: '1.80 m',
      largo: '4.52 m',
      enOferta: false,
      colores: ['Rojo', 'Negro', 'Azul'],
    ),
    Auto(
      nombre: 'Honda Accord',
      imagenUrl: 'assets/images/honda-accord.jpg',
      precio: '\$27,000',
      motor: '1.5L Turbo Inline-4',
      alto: '1.45 m',
      ancho: '1.86 m',
      largo: '4.90 m',
      enOferta: false,
      colores: ['Blanco', 'Negro', 'Gris'],
    ),
    Auto(
      nombre: 'Volkswagen Golf',
      imagenUrl: 'assets/images/volkswagen-golf.jpeg',
      precio: '\$23,000',
      motor: '1.4L Turbo Inline-4',
      alto: '1.45 m',
      ancho: '1.79 m',
      largo: '4.28 m',
      enOferta: false,
      colores: ['Blanco', 'Rojo', 'Negro'],
    ),
    Auto(
      nombre: 'Porsche 911',
      imagenUrl: 'assets/images/porsche-911.jpeg',
      precio: '\$100,000',
      motor: '3.0L Twin-Turbo Flat-6',
      alto: '1.30 m',
      ancho: '1.85 m',
      largo: '4.52 m',
      enOferta: false,
      colores: ['Negro', 'Blanco', 'Azul'],
    ),
    Auto(
      nombre: 'Lamborghini Huracán',
      imagenUrl: 'assets/images/lambo-huracan.jpeg',
      precio: '\$200,000',
      motor: '5.2L V10',
      alto: '1.17 m',
      ancho: '2.03 m',
      largo: '4.52 m',
      enOferta: false,
      colores: ['Amarillo', 'Negro', 'Naranja'],
    ),
    Auto(
      nombre: 'Ferrari F8',
      imagenUrl: 'assets/images/ferrari-f8.jpeg',
      precio: '\$250,000',
      motor: '3.9L Twin-Turbo V8',
      alto: '1.21 m',
      ancho: '1.97 m',
      largo: '4.61 m',
      enOferta: false,
      colores: ['Rojo', 'Negro', 'Blanco'],
    ),
    Auto(
      nombre: 'McLaren 720S',
      imagenUrl: 'assets/images/mclaren.jpeg',
      precio: '\$300,000',
      motor: '4.0L Twin-Turbo V8',
      alto: '1.21 m',
      ancho: '2.05 m',
      largo: '4.50 m',
      enOferta: false,
      colores: ['Naranja', 'Negro', 'Plateado'],
    ),
  ];
}