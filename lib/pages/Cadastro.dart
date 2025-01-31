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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }
  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          buildTextFormField(
            controller: imagemController,
            text: '"Caminho do Arquivo da Imagem',
          ),
          buildTextFormField(
            controller: tituloController,
            text: 'Título',
          ),
          buildTextFormField(
            controller: subtituloController,
            text: 'Subtitulo',
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: onPressed,
            child: const Text(
              'Cadastrar Card',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
  buildTextFormField({
    required TextEditingController controller,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: fieldValidator,
        decoration: buildInputDecoration(text),
        cursorColor: Colors.deepPurpleAccent,
      ),
    );
  }
  String? fieldValidator(value) {
    if (value == null || value.isEmpty) {
      return "Este campo não pode ser vazio!";
    } else {
      return null;
    }
  }
  buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.deepPurpleAccent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: const Text(
        'Nova Doação',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  buildInputDecoration(String name) {
    return InputDecoration(
      label: Text(name),
      floatingLabelStyle: TextStyle(
        color: Colors.deepPurpleAccent,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 2,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
  Future<void> onPressed() async {
    String imagem = imagemController.text;
    String titulo = tituloController.text;
    String subtitulo = subtituloController.text;

    Doacoes doacao = Doacoes(
      imagem: imagem,
      titulo: titulo,
      subtitulo: subtitulo,
    );

    await CardsDao().salvarDoacao(doacao, 1);
    Navigator.pop(context);
  }
}