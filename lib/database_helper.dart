import 'dart:async';
import 'package:path/path.dart';
import 'package:minhasdoacoes/transacao.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;


  DatabaseHelper._init();


  Future<Database> get database async {
    if (_database != null) return _database!;


    _database = await _initDB('doacoes.db');
    return _database!;
  }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);


    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';


    await db.execute('''
   CREATE TABLE transacoes (
     id $idType,
     nome $textType,
     instituicao $textType,
     valor $realType,
     pix $textType,
     data $textType,
     hora $textType
   )
   ''');
  }

  Future<int> insertTransacao(Transacao transacao) async {
    final db = await instance.database;
    return await db.insert('transacoes', transacao.toMap());
  }

  Future<List<Transacao>> getTransacoes() async {
    final db = await instance.database;
    final result = await db.query('transacoes');
    return result.map((json) => Transacao.fromMap(json)).toList();
  }

  Future<int> updateTransacao(Transacao transacao) async {
    final db = await instance.database;
    return await db.update(
      'transacoes',
      transacao.toMap(),
      where: 'id = ?',
      whereArgs: [transacao.id],
    );
  }

  Future<int> deleteTransacao(int id) async {
    final db = await instance.database;
    return await db.delete(
      'transacoes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
