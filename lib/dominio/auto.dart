class Auto {
  final int? id;
  final String nombre, imagenUrl, precio, motor, alto, ancho, largo;
  final bool enOferta;
  final List<String> colores;

  Auto({
    this.id,
    required this.nombre,
    required this.imagenUrl,
    required this.precio,
    required this.motor,
    required this.largo,
    required this.ancho, 
    required this.alto,
    required this.enOferta,
    required this.colores
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'nombre': nombre,
    'imagenUrl': imagenUrl,
    'precio': precio,
    'motor': motor,
    'alto': alto,
    'ancho': ancho,
    'largo': largo,
    'enOferta' : enOferta ? 1 : 0,
    'colores': colores.join(','),
  };

  factory Auto.fromMap(Map<String, dynamic> m) => Auto(
    id: m['id'] as int?,
    nombre: m['nombre'],
    imagenUrl: m['imagenUrl'],
    precio: m['precio'],
    motor: m['motor'],
    alto: m['alto'],
    ancho: m['ancho'],
    largo: m['largo'],
    enOferta: (m['enOferta'] as int) == 1,
    colores: (m['colores'] as String).split(','),
  );
}