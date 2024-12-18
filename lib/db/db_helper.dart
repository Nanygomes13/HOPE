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
        'CREATE TABLE CARD1 (id INTEGER PRIMARY KEY AUTOINCREMENT, imagem varchar(100), titulo varchar(100), subtitulo varchar(100));';
    await db.execute(sql);

    sql =
    "INSERT INTO CARD1 (imagem, titulo, subtitulo) VALUES ('images/card-2.jpg', 'Alimentos doados à comunidade Espírita Nosso Lar', 'há 2 dias');";
    await db.execute(sql);

    sql =
    "INSERT INTO CARD1 (imagem, titulo, subtitulo) VALUES ('images/card-3.jpg', 'Kits de material escolar doados para a Escola Municipal...', 'há 8 horas');";
    await db.execute(sql);

    sql =
        'CREATE TABLE CARD2 (id INTEGER PRIMARY KEY AUTOINCREMENT, imagem varchar(100),valor double);';
    await db.execute(sql);

    sql =
    "INSERT INTO CARD2 (imagem, valor) VALUES ('images/card-4.png', '577000');";
    await db.execute(sql);

    sql =
    "INSERT INTO CARD2 (imagem, valor) VALUES ('images/card-5.png', '127000');";
    await db.execute(sql);

    sql =
    "INSERT INTO CARD2 (imagem, valor) VALUES ('images/card-6.png', '10990');";
    await db.execute(sql);
  }
}