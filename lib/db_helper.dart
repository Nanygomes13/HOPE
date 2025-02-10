import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, "materiais.db");
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
        'CREATE TABLE MATERIAIS (id INTEGER PRIMARY KEY AUTOINCREMENT, nome_materiais varchar(100), quant INTEGER, endereco varchar(200), prazo varchar(50));';
    await db.execute(sql);

    sql =
    "INSERT INTO MATERIAIS (nome_materiais, quant, endereco, prazo) VALUES ('Calça jeans, ventilador e camisa polo', 3, 'Arapiraca - AL', '7 dias úteis');";
    await db.execute(sql);
  }
}