import 'package:flutter/rendering.dart';
import 'package:hopee/domain/news.dart';
import 'package:dio/dio.dart';

class NewsApi {
  final domain = 'https://newsapi.org/v2/everything';
  final String keyword = 'doação de bens materiais" OR "dinheiro" OR "alimentos';
  final String apiKey = 'caca8ab1cd954f0599d500ae67b5dd93';

  final dio = Dio();

  Future<List<Article>> findArticlesByKeyword(String keyword) async {
    final response = await dio.get(
        '$domain',
        queryParameters: {
          'q': keyword,//'$keyword AND (doação OR caridade OR arrecadação OR voluntariado)',
          'apiKey': '$apiKey',
          'language': 'pt',
          'sortBy': 'publishedAt',
        }
    );

    List<dynamic> artigosJson = response.data['articles'];
    List<Article> artigos = [];

    for(var json in artigosJson){
      Article a = Article.fromJson(json);
      artigos.add(a);
    }

    print(artigos);
    return artigos;

  }
}



