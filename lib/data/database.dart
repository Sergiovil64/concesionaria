// lib/data/database_helper.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instancia = DatabaseHelper._();

  // Patron Singleton
  factory DatabaseHelper() => _instancia;
  DatabaseHelper._();

  static Database? _db;
  Future<Database> get db async => _db ??= await _initDB();

  Future<Database> _initDB() async {
    // Obtener path dinamicamente
    final path = join(await getDatabasesPath(), 'concesionaria.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: (db, oldV, newV) async {
      if (newV > oldV) {
        await db.execute('DROP TABLE IF EXISTS cars;');
        await db.execute('DROP TABLE IF EXISTS promoter_requests;');
        await _onCreate(db, newV);
      }
  },
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS autos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        imagenUrl TEXT,
        precio TEXT,
        motor TEXT,
        alto TEXT,
        ancho TEXT,
        largo TEXT,
        enOferta INTEGER,
        colores TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS solicitud_promotores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clienteNombre TEXT,
        clienteEmail TEXT,
        clienteCiudad TEXT,
        clienteCelular TEXT,
        fecha DATE
      );
    ''');
  }
}
