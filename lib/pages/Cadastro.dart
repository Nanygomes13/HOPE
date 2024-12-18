import 'package:hopee/db/cards_dao.dart';
import 'package:flutter/material.dart';
import 'package:hopee/domain/doacoes.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override

  final TextEditingController imagemController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController subtituloController = TextEditingController();
  final TextEditingController valorController = TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: buildAppBar(),
          body: buildBody(),
        ),
    );
  }
}
