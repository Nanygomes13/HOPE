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
  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          buildTextFormField(
            controller: imagemController,
            text: '"Caminho do Arquivo da Imagem',
          ),
          buildTextFormField(
            controller: cidadeController,
            text: 'Título',
          ),
          buildTextFormField(
            controller: tituloController,
            text: 'Subtitulo',
          ),
          buildTextFormField(
            controller: tituloAnoController,
            text: 'Valor',
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Colors.deepPurpleAccent,
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
        cursorColor: const Colors.deepPurpleAccent,
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
      backgroundColor: const Colors.deepPurpleAccent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: const Text(
        'Nova Doação'',
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
      floatingLabelStyle: (
        color: const Colors.deepPurpleAccent,
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
    String valor = valorController.text;

    Doacoes doacao = Doacoes(
      imagem: imagem,
      titulo: titulo,
      subtitulo: subtitulo,
      valor: valor,
    );

    await cards_dao().salvarDoacoes(doacao);
    Navigator.pop(context);
  }
}
