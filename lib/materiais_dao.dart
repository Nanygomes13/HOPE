import 'package:hopee/db_helper.dart';
import 'package:hopee/doacao_materiais.dart';
import 'package:sqflite/sqflite.dart';

class MateriaisDao {

  salvarAlimentos(DoacaoMateriais materiais) async {
    Database database = await DBHelper().initDB();
    database.insert('MATERIAIS', materiais.toJson());
  }

  Future<List<DoacaoMateriais>> listarMateriais() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM MATERIAIS;';

    var result = await db.rawQuery(sql);

    List<DoacaoMateriais> lista = [];
    for (var json in result) {
      DoacaoMateriais materiais = DoacaoMateriais.fromJson(json);
      lista.add(materiais);
    }

    return lista;
  }
}