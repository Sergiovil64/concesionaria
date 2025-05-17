// lib/pages/cotizacion_page.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarea3/aplicacion/riverpod.dart';
import 'package:tarea3/data/consultas_ia.dart';
import 'package:tarea3/dominio/promotor.dart';

class Cotizacion extends HookConsumerWidget {
  const Cotizacion({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ImagePicker picker = ImagePicker();

    final nombreCtrl   = useTextEditingController();
    final emailCtrl    = useTextEditingController();
    final ciudadCtrl   = useTextEditingController();
    final phoneCtrl    = useTextEditingController();

    final containerState = ref.watch(containerProvider);
    final total = containerState.vAutosCarrito.fold<int>(0, (sum, car) {
      final digits = car.precio.replaceAll(RegExp(r'[^\d]'), '');
      return sum + int.parse(digits);
    });

      Future<void> pickTradeInImage() async {
        final XFile? img = await picker.pickImage(source: ImageSource.camera);
        if (img == null) return;
        ref.read(containerProvider.notifier).guardarImagen(img.path);
        final bytes = await img.readAsBytes();
        final b64   = base64Encode(bytes);

        bool esVehiculo = await ConsultaIA.esVehiculo(b64);
        if (!esVehiculo) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No es un vehículo.")),
          );
          return;
        }

        final modeloPrecio = await ConsultaIA.obtenerModeloPrecio(b64);
        containerState.modeloAutoIA = modeloPrecio[0];
        containerState.precioAutoIA = modeloPrecio[1];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Vehículo reconocido: ${modeloPrecio[0]}; Precio estimado: ${modeloPrecio[1]}"), duration: Duration(seconds: 10),),
        );
      }

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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 8),
              if (containerState.vAutosCarrito.isEmpty)
                Text('No hay artículos en el carrito.', style: TextStyle(color: Colors.black),)
              else
                ...containerState.vAutosCarrito.map((car) => Container(
                  color: Colors.white,
                  child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(car.imagenUrl,
                              width: 48, height: 32, fit: BoxFit.cover),
                        ),
                        title: Text(car.nombre),
                        trailing: Text(car.precio),
                      ),
                )),
              const SizedBox(height: 8),
              Text('Total: \$${total.toString()}', 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
              const Divider(height: 32, color: Colors.black,),
        
              Text('Cotiza con tu auto como parte de pago subiendo una fotografia',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: pickTradeInImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        containerState.imagenCamara.isNotEmpty ? FileImage(File(containerState.imagenCamara)) : null,
                    child: containerState.imagenCamara.isEmpty
                        ? Icon(Icons.camera_alt, size: 32, color: Colors.grey[600])
                        : null,
                  ),
                ),
              ),
              
              const Divider(height: 32),
        
              Text('Datos del Cliente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 12),
              TextField(
                controller: nombreCtrl,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Nombre de cliente',
                  hintStyle: TextStyle(color: Colors.redAccent.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailCtrl,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  hintStyle: TextStyle(color: Colors.redAccent.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneCtrl,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Teléfono',
                  hintStyle: TextStyle(color: Colors.redAccent.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ciudadCtrl,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Ciudad',
                  hintStyle: TextStyle(color: Colors.redAccent.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 24),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final solicitud = SolicitudPromotor(
                      clienteNombre: nombreCtrl.value.text, 
                      clienteEmail: emailCtrl.value.text, 
                      clienteCiudad: ciudadCtrl.value.text, 
                      clienteTelefono: phoneCtrl.value.text
                    );
                    ref.read(containerProvider.notifier).insertarSolicitud(solicitud).then((val) {
                      final mensaje = val == 0 ? 'Ha ocurrido un error' : 'Solicitud enviada.';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(mensaje)),
                      );
                    });
                    nombreCtrl.clear();
                    emailCtrl.clear();
                    ciudadCtrl.clear();
                    phoneCtrl.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.red
                  ),
                  child: Text('Solicita Promotor', style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

