// lib/pages/cotizacion_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarea3/aplicacion/riverpod.dart';

class Cotizacion extends ConsumerStatefulWidget {
  const Cotizacion({Key? key}) : super(key: key);

  @override
  ConsumerState<Cotizacion> createState() => _CotizacionState();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get canRequestFocus => false;
}

class _CotizacionState extends ConsumerState<Cotizacion> {
  final ImagePicker _picker = ImagePicker();
  File? _tradeInImage;

  final _modeloController        = TextEditingController();
  final _precioApproxController  = TextEditingController();
  final _nombreController        = TextEditingController();
  final _emailController         = TextEditingController();
  final _ciudadController        = TextEditingController();

  @override
  void dispose() {
    _modeloController.dispose();
    _precioApproxController.dispose();
    _nombreController.dispose();
    _emailController.dispose();
    _ciudadController.dispose();
    super.dispose();
  }

  Future<void> _pickTradeInImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() => _tradeInImage = File(img.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final containerState = ref.watch(containerProvider);
    final total = containerState.vAutosCarrito.fold<int>(0, (sum, car) {
      final digits = car.precio.replaceAll(RegExp(r'[^\d]'), '');
      return sum + int.parse(digits);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Cotización', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.redAccent.shade200,
      ),
      body: Container(
        color: Colors.red.shade100,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resumen del Carrito',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (containerState.vAutosCarrito.isEmpty)
                Text('No hay artículos en el carrito.')
              else
                ...containerState.vAutosCarrito.map((car) => ListTile(
                      tileColor: Colors.white,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(car.imagenUrl,
                            width: 48, height: 32, fit: BoxFit.cover),
                      ),
                      title: Text(car.nombre),
                      trailing: Text(car.precio),
                    )),
              const SizedBox(height: 8),
              Text('Total: \$${total.toString()}', 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const Divider(height: 32),
        
              Text('Cotiza con tu auto como parte de pago',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: _pickTradeInImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        _tradeInImage != null ? FileImage(_tradeInImage!) : null,
                    child: _tradeInImage == null
                        ? Icon(Icons.camera_alt, size: 32, color: Colors.grey[600])
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _modeloController,
                readOnly: true,                              
                showCursor: false,
                focusNode: AlwaysDisabledFocusNode(),
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _precioApproxController,
                readOnly: true,                              
                showCursor: false,
                focusNode: AlwaysDisabledFocusNode(),
                enableInteractiveSelection: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio aproximado',
                  prefixText: '\$',
                  border: OutlineInputBorder(),
                ),
              ),
              const Divider(height: 32),
        
              Text('Datos del Cliente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre de cliente',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _ciudadController,
                decoration: InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes procesar la cotización o llamar a un provider
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Solicitud enviada')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.red
                  ),
                  child: Text('Solicita Promotor'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
