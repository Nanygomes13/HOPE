import 'package:hopee/db/db_helper.dart';
import 'package:hopee/domain/doacao_alimentos.dart';
import 'package:sqflite/sqflite.dart';

class AlimentosDao {

  salvarAlimentos(DoacaoAlimentos alimentos) async {
    Database database = await DBHelper().initDB();
    database.insert('ALIMENTOS', alimentos.toJson());
  }

  Future<List<DoacaoAlimentos>> listarAlimentos() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM ALIMENTOS;';

    var result = await db.rawQuery(sql);

    List<DoacaoAlimentos> lista = [];
    for (var json in result) {
      DoacaoAlimentos alimentos = DoacaoAlimentos.fromJson(json);
      lista.add(alimentos);
    }

    return lista;
  }
}
