import 'package:flutter/material.dart';
import 'package:hopee/db/alimentos_dao.dart';
import 'package:hopee/domain/doacao_alimentos.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  late Future<List<DoacaoAlimentos>> futureAlimentos;

  @override
  void initState() {
    super.initState();
    futureAlimentos = AlimentosDao().listarAlimentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Alimentos Cadastrados",
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<List<DoacaoAlimentos>>(
        future: futureAlimentos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Ocorreu um erro inesperado!",
                ),
            );
          } else {
            List<DoacaoAlimentos> alimentos = snapshot.data ?? [];
            if (alimentos.isEmpty) {
              return const Center(
                child: Text("Nenhum alimento cadastrado."),
              );
            }

            return ListView.builder(
              itemCount: alimentos.length,
              itemBuilder: (context, index) {
                final alimento = alimentos[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      alimento.nome_alimento,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Quantidade: ${alimento.quant}\n"
                      "Endereço: ${alimento.endereco}\n"
                      "Prazo: ${alimento.prazo}",
                    ),
                    leading: const Icon(Icons.fastfood, color: Colors.deepPurpleAccent),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
