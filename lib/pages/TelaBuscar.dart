import 'package:flutter/material.dart';
import 'package:hopee/pages/TelaInicial.dart';
import 'package:hopee/domain/article.dart';
import 'package:hopee/api/news_api.dart';

class TelaBuscar extends StatefulWidget {
  String stringBusca;

  TelaBuscar({super.key, this.stringBusca = ''});

  @override
  State<TelaBuscar> createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {
  TextEditingController _searchController = TextEditingController();

  Future<List<Article>>? _articlesFuture;

  @override
  void initState() {
    super.initState();
    initialSearch();
  }

  initialSearch() {
    if (widget.stringBusca.isNotEmpty) {
      _searchController.text = widget.stringBusca;
      _articlesFuture = NewsApi().findArticlesByKeyword(widget.stringBusca);
    }
  }

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
            FutureBuilder(
              future: _articlesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ocorreu um erro inesperado.",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Text('Nenhum resultado encontrado');
                  }

                  List<Article> articles = snapshot.data ?? [];

                  return Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, i) {
                        var article = articles[i];

                        return Card(
                          child: Column(
                            children: [
                              Text(article.title),
                              Text(article.description),
                              Text(article.publishedAt),
                              Text(article.author),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> onPressedSearchButton() async {
    String keyword = _searchController.text;

    if (keyword.isNotEmpty) {
      setState(() {
        _articlesFuture = NewsApi().findArticlesByKeyword(keyword);
      });
    }
  }
}
