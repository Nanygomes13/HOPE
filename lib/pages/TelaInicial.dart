import 'package:hopee/db/cards_dao.dart';
import 'package:flutter/material.dart';
import 'package:hopee/domain/doacoes.dart';
import 'package:hopee/pages/TelaBuscar.dart';
import 'package:hopee/pages/Cadastro.dart'; // Tela de cadastro


class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<Doacoes> doacoesCard1 = [];
  List<Doacoes> doacoesCard2 = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    doacoesCard1 = await CardsDao().listarDoacoesCard1();
    doacoesCard2 = await CardsDao().listarDoacoesCard2();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        floatingActionButton: buildFloatingActionButton(),
        body: ListView(
          children: [
            buildContainerPropaganda(),
            // Lista de doações destacadas
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: doacoesCard1.length,
              itemBuilder: (context, i) {
                return buildCardDoacoes(doacoesCard1[i]);
              },
            ),
            // Ranking de doações
            const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
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
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: doacoesCard2.length,
                itemBuilder: (context, i) {
                  return buildCardRanking(doacoesCard2[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AppBar similar ao do professor
  buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xFF10397B),
      actions: [
        IconButton(
          onPressed: () {
            // Lógica de logout
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        )
      ],
      title: const Text(
        'Pesquisar',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // FloatingActionButton para cadastro
  buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF3F68F7),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Cadastro(); // Tela de cadastro
            },
          ),
        ).then((value) async {
          await loadData();
          setState(() {});
        });
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  // Container de propaganda
  buildContainerPropaganda() {
    return Container(
      margin: const EdgeInsets.all(16),
      color: Colors.deepPurple,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Tops destinos mais buscados',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Corre que ta rolando muita promoção',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    child: const Text(
                      'EU QUERO!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Image.network(
            'https://img.freepik.com/fotos-gratis/casal-multirracial-com-bola-posando-na-praia_23-2148137988.jpg',
            height: 170,
          ),
        ],
      ),
    );
  }

  // Função para renderizar o card das doações
  buildCardDoacoes(Doacoes doacao) {
    return Card(
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
              doacao.imagem,
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
                  doacao.titulo!,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 7),
                Text(doacao.subtitulo!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Função para renderizar o card do ranking
  buildCardRanking(Doacoes doacao) {
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
                    doacao.imagem,
                    width: 115,
                    height: 65,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('R\$ ${doacao.valor}'),
        ],
      ),
    );
  }
}
