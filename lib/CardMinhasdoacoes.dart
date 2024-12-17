import 'package:flutter/material.dart';
import 'package:hopee/transacao.dart';

class CardMinhasdoacoes extends StatefulWidget {
  final Transacao transacao;

  const CardMinhasdoacoes({super.key, required this.transacao});

  @override
  State<CardMinhasdoacoes> createState() => _CardMinhasdoacoesState();
}
class _CardMinhasdoacoesState extends State<CardMinhasdoacoes> {
  Transacao get doacoes => widget.transacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(doacoes.nome),
        subtitle: Text(doacoes.instituicao),
        trailing: Text("R\$ ${doacoes.valor.toStringAsFixed(2)}"),
      ),
    );
  }
}