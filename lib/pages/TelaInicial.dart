import 'package:flutter/material.dart';
import 'package:myapp/db/database.dart';
import 'package:myapp/domain/doacoes.dart';
import 'package:myapp/pages/TelaBuscar.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 36,
            ),
            onPressed: () {},
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          title: Column(
            children: [
              Image.asset(
                'images/hope.png',
                width: 150,
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Column(
                children: [
                  TextField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const TelaBuscar();
                        }),
                      );
                    },
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 240, 205, 243),
                      filled: true,
                      prefixIcon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const TelaBuscar();
                            }),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      hintText: 'Pesquisar',
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
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 300,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'images/card-1.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Destaques',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Ver tudo',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Database.doacao1.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    Database.doacao1[i].imagem,
                                    width: 200,
                                    height: 127,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Database.doacao1[i].titulo!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(Database.doacao1[i].subtitulo!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Ranking da Solidariedade',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Database.doacao2.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          width: 150,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Image.asset(
                                        Database.doacao2[i].imagem,
                                        width: 115,
                                        height: 65,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(Database.doacao2[i].valor!),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'images/card-7.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
