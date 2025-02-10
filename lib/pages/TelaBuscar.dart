import 'package:flutter/material.dart';
import 'package:hopee/pages/TelaInicial.dart';
import 'package:hopee/domain/article.dart';
import 'package:hopee/api/news_api.dart';

class TelaBuscar extends StatefulWidget {
  const TelaBuscar({super.key});

  @override
  State<TelaBuscar> createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {
  TextEditingController _searchController = TextEditingController();
  String _statusMessage = "Quem você deseja ajudar hoje?";
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.deepPurpleAccent,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 240, 205, 243),
                          filled: true,
                          prefixIcon: IconButton(
                            onPressed: onPressedSearchButton,
                            icon: const Icon(Icons.search),
                            color: Colors.deepPurpleAccent,
                          ),
                          hintText: 'Pesquisar',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            hasError(),
          ],
        ),
      ),
    );
  }

  Widget hasError() {
    if (_hasError) {
      return Center(
        child: Text(
          "Ocorreu um erro inesperado.",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Column(
        children: [
          Center(
            child: Image.asset(
              'images/busca.png',
              width: 250,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              _statusMessage,
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: SizedBox(
              width: 300,
              child: Text(
                'Digite uma palavra-chave para pesquisar.',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<void> onPressedSearchButton() async {
    String keyword = _searchController.text;

    if (keyword.isEmpty) {
      setState(() {
        _statusMessage = "Nenhum resultado encontrado.";
        _hasError = true;
      });

      return;
    }

    try {
      List<Article> articles = await NewsApi().findArticlesByKeyword(keyword);

      if (articles.isEmpty) {
        setState(() {
          _statusMessage = "Nenhum resultado encontrado.";
          _hasError = false;
        });
      } else {
        for (var article in articles) {
          print(article.toString());
        }
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    }
  }
}
