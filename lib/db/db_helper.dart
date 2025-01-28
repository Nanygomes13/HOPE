import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "alimentos.db");
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
        'CREATE TABLE ALIMENTOS (id INTEGER PRIMARY KEY AUTOINCREMENT, nome_alimento varchar(100), quant INTEGER, endereco varchar(200), prazo varchar(50));';
    await db.execute(sql);

    sql =
    "INSERT INTO ALIMENTOS (nome_alimento, quantidade, endereco, prazo) VALUES ('Arroz, feijão, farinha, açúcar e sal', 5, 'Feira Grande - AL', '2 dias úteis');";
    await db.execute(sql);
  }
}
