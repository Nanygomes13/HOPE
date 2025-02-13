import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hopee/pages/agradecimento.dart';
import 'package:hopee/db/alimentos_dao.dart';
import 'package:hopee/domain/doacao_alimentos.dart';
import 'package:hopee/pages/map.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nome_alimentoController = TextEditingController();
  final TextEditingController quantController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController prazoController = TextEditingController();

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
              controller: nome_alimentoController,
              text: 'Alimento(s)',
          ),
          buildTextFormField(
              controller: quantController,
              text: 'Quant.',
              keyboardType: TextInputType.number,
          ),
          buildTextFormField(
              controller: enderecoController,
              text: 'Endereço',
              suffixIcon: IconButton(
                icon: const Icon(
                    Icons.location_on,
                    color: Colors.deepPurpleAccent,
                ),
                onPressed: () async {
                  String endereco = enderecoController.text;
                  if (endereco.isNotEmpty) {
                    Location location = await locationFromAddress(endereco).then((locations) => locations.first);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage(location: location)),
                    );
                  }
                }
              ),
            ),
          buildTextFormField(
              controller: prazoController,
              text: 'Prazo',
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
              'Salvar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  buildTextFormField({
    required TextEditingController controller,
    required String text,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: fieldValidator,
        decoration: buildInputDecoration(text, suffixIcon),
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

  buildInputDecoration(String name, Widget? suffixIcon) {
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
    String nomeAlimento = nome_alimentoController.text;
    int quant = int.tryParse(quantController.text) ?? 0;
    String endereco = enderecoController.text;
    String prazo = prazoController.text;

    DoacaoAlimentos alimentos = DoacaoAlimentos(
      nome_alimento: nomeAlimento,
      quant: quant,
      endereco: endereco,
      prazo: prazo,
    );

    await AlimentosDao().salvarAlimentos(alimentos);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) {
            return agradecimento();
          }
      ),
    );
  }
}

