import 'package:hopee/domain/news.dart';
import 'package:dio/dio.dart';

class NewsApi {
  final domain = 'https://newsapi.org/v2/everything';
  final String keyword = 'doação de bens materiais" OR "dinheiro" OR "alimentos';
  final String apiKey = 'caca8ab1cd954f0599d500ae67b5dd93';

  final dio = Dio();

  Future<News> findAddressByKeyword(String keyword) async {
    final response = await dio.get(
        '$domain',
        queryParameters: {
          'q': '$keyword AND (doação OR caridade OR arrecadação OR voluntariado)',
          'apiKey': '$apiKey',
          'language': 'pt',
          'sortBy': 'publishedAt',
        }
    );

    List<dynamic> news = response.data['articles'];

    print(response);
    return news;

  }
}



