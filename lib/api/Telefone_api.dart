import 'package:dio/dio.dart';
import 'package:hopee/domain/local.dart';

class TelefoneApi {
  final domain = 'https://brasilapi.com.br/api';
  final dio = Dio();

  Future<Local> findTelefoneByDdd(String ddd) async {
    final response = await dio.get('$domain/ddd/v1/$ddd');
    Local telefone = Local.fromJson(response.data);

    print(response);
    return telefone;
  }
}