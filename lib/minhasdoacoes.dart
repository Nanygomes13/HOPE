import 'package:flutter/material.dart';
import 'package:hopee/transacao.dart';
import 'package:hopee/transacaoDao.dart';
import 'package:hopee/CadastroTransacao.dart';
import 'package:hopee/CardMinhasdoacoes.dart';

class MinhasDoacoes extends StatefulWidget {
  const MinhasDoacoes({super.key});

  @override
  State<MinhasDoacoes> createState() => _MinhasDoacoesState();
}

class _MinhasDoacoesState extends State<MinhasDoacoes> {
  List<Transacao> transacoes = [];

  @override
  void initState() {
    super.initState();
    _loadTransacoes();
  }

  void _loadTransacoes() async {
    final transacoesFromDb = await TransacaoDao().listarTransacoes();
    setState(() {
      transacoes = transacoesFromDb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "MINHAS DOAÇÕES",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroTransacao()),
                );
                _loadTransacoes(); // Atualiza a lista após adicionar nova transação
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 20),
              Expanded(child: _buildTransactionList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.deepPurpleAccent),
        hintText: 'Busque por Título ou valor',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      itemCount: transacoes.length,
      itemBuilder: (context, index) {
        return CardMinhasdoacoes(transacao: transacoes[index]);
      },
    );
  }
}
