import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "cards.db");
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );

    print(dbPath);
    return database;
  }

  Future<FutureOr<void>> onCreate(Database db, int version) async {
    String sql =
        'CREATE TABLE CARD (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo varchar(100), descricao varchar(100), imagem varchar(100));';
    await db.execute(sql);

    String sql =
        'CREATE TABLE CARD (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo varchar(100), descricao varchar(100), imagem varchar(100));';
    await db.execute(sql);
  }
}