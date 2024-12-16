import 'package:flutter/material.dart';
import 'package:minhasdoacoes/CadastroTransacao.dart';
import 'package:minhasdoacoes/CardMinhasdoacoes.dart';
import 'package:minhasdoacoes/db/database.dart';


class minhasdoacoes extends StatefulWidget {
  const minhasdoacoes({
    super.key,
  });

  @override
  State<minhasdoacoes> createState() => _minhasdoacoesState();
}

class _minhasdoacoesState extends State<minhasdoacoes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "MINHAS DOAÇÕES",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: ()async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroTransacao()),
                );
                setState(() {});
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
  Widget _buildSearchField(){
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.deepPurpleAccent),
        hintText: 'Busque por Título ou valor',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
    );
  }
  Widget _buildTransactionList(){
    return ListView.builder(
      itemCount: Database.doacoes.length,
      itemBuilder: (context, index){
        return CardMinhasdoacoes(transacao: Database.doacoes[index]);
      },
    );
  }
}


