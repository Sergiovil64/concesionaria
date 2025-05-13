import 'package:tarea3/data/database.dart';
import 'package:tarea3/dominio/promotor.dart';

class DBPromotor {
  Future<int> insertRequest(SolicitudPromotor req) async {
    final database = await DatabaseHelper().db;
    return await database.insert('solicitud_promotores', req.toMap());
  }

  Future<List<SolicitudPromotor>> getAllRequests() async {
    final database = await DatabaseHelper().db;
    final rows = await database.query('solicitud_promotores');
    return rows.map((m) => SolicitudPromotor.fromMap(m)).toList();
  }
}