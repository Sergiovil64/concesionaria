class SolicitudPromotor {
  final int? id;
  final String clienteNombre, clienteEmail, clienteCiudad, clienteTelefono;
  final DateTime fecha;

  SolicitudPromotor({
    this.id,
    required this.clienteNombre,
    required this.clienteEmail,
    required this.clienteCiudad,
    required this.clienteTelefono,
    DateTime? fecha,
  }) : fecha = fecha ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'clienteNombre': clienteNombre,
    'clienteEmail': clienteEmail,
    'clienteCiudad': clienteCiudad,
    'fecha': fecha,
  };

  factory SolicitudPromotor.fromMap(Map<String, dynamic> m) =>
    SolicitudPromotor(
      id: m['id'] as int?,
      clienteNombre: m['clienteNombre'],
      clienteEmail: m['clienteEmail'],
      clienteCiudad: m['clienteCiudad'],
      clienteTelefono: m['clienteTelefono'],
      fecha: DateTime.parse(m['fecha']),
    );
}
