import 'package:hopee/cadastro.dart';
import 'package:hopee/domain/user.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class PacoteDao {

  Future<void> salvarPacote(User pacote) async {
    Database database = await DBHelper().initDB();
    database.insert('PACOTE', pacote.toJson());
  }

  Future<List<User>> listarPacotes() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM PACOTE;';

    var result = await db.rawQuery(sql);

    List<User> lista = [];
    for (var json in result) {
      User pacote = User.fromJson(json);
      lista.add(pacote);
    }

    await Future.delayed(const Duration(seconds: 4));
    return lista;
  }
}