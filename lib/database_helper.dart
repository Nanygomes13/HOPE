import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hopee/transacao.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'doacoes.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        instituicao TEXT,
        valor REAL,
        pix TEXT,
        data TEXT,
        hora TEXT
      )
    ''');
  }

  Future<int> insertTransacao(Transacao transacao) async {
    final db = await database;
    return await db.insert('transacoes', transacao.toMap());
  }

  Future<List<Transacao>> getTransacoes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transacoes');

    return List.generate(maps.length, (i) {
      return Transacao(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        instituicao: maps[i]['instituicao'],
        valor: maps[i]['valor'],
        pix: maps[i]['pix'],
        data: maps[i]['data'],
        hora: maps[i]['hora'],
      );
    });
  }
}
