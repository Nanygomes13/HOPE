import 'package:hopee/db/db_helper.dart';
import 'package:hopee/domain/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  Future<bool> autenticar(String username, String password) async {
    Database db = await DBHelper().initDB();

    String sql = 'SELECT * FROM USER '
        'WHERE USERNAME = ? AND PASSWORD = ?;';
    var result = await db.rawQuery(sql, [username, password]);

    print('Resultado da autenticação: $result'); // Debug
    return result.isNotEmpty;
  }

  Future<void> saveUser(User user) async {
    Database db = await DBHelper().initDB();
    await db.insert('USER', user.toJson());
    print('Usuário salvo: ${user.toJson()}'); // Debug
  }
}
