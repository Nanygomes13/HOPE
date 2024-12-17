import 'package:sqflite/sqflite.dart';
import 'package:hopee/transacao.dart';
import 'package:hopee/database_helper.dart';


class TransacaoDao {

  Future<int> salvarTransacao(Transacao transacao) async {
    final db = await DatabaseHelper().database;
    return await db.insert('transacoes', transacao.toMap());
  }

  Future<List<Transacao>> listarTransacoes() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('transacoes');

    return List.generate(maps.length, (i) {
      return Transacao.fromMap(maps[i]);
    });
  }
}
