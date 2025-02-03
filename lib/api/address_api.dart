import '../db/local.dart';

class AddressApi {
  final domain = 'https://brasilapi.com.br/api/ddd/v1/{ddd}';
  final dio = Dio();

  Future<local> findAddressByCep(String cep) async {
    final response = await dio.get('$domain/cep/v2/$cep');
    local address = local.fromJson(response.data);

    print(response);
    return address;
  }
}