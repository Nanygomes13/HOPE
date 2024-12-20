import 'package:hopee/db/db_helper.dart';
import 'package:hopee/domain/doacoes.dart';
import 'package:sqflite/sqflite.dart';

class CardsDao {

  salvarDoacao(Doacoes doacao, int tipo) async {
    Database database = await DBHelper().initDB();

    if (tipo == 1) {
      database.insert('CARD1', doacao.toJson());
    } else if (tipo == 2) {
      database.insert('CARD2', doacao.toJson());
    }
  }

  Future<List<Doacoes>> listarDoacoesCard1() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM CARD1;';

    var result = await db.rawQuery(sql);

    List<Doacoes> lista = [];
    for (var json in result) {
      Doacoes doacao = Doacoes.fromJson(json);
      lista.add(doacao);
    }

    return lista;
  }

  Future<List<Doacoes>> listarDoacoesCard2() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM CARD2;';

    var result = await db.rawQuery(sql);
    List<Doacoes> lista = [];
    for (var json in result) {
      Doacoes doacao = Doacoes.fromJson(json);
      lista.add(doacao);
    }

    return lista;
  }
}


