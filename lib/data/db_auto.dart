import 'package:tarea3/data/database.dart';
import 'package:tarea3/dominio/auto.dart';

class DBAuto {
  Future<int> insertCar(Auto car) async {
    final database = await DatabaseHelper().db;
    return await database.insert('autos', car.toMap());
  }

  Future<List<Auto>> getAllCars() async {
    final database = await DatabaseHelper().db;
    final rows = await database.query('autos');
    return rows.map((m) => Auto.fromMap(m)).toList();
  }

  Future<int> deleteAllCars() async {
    final database = await DatabaseHelper().db;
    return await database.delete('autos');
  }
}