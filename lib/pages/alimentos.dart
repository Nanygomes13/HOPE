import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hopee/pages/agradecimento.dart';
import 'package:hopee/db/alimentos_dao.dart';
import 'package:hopee/domain/doacao_alimentos.dart';
import 'package:hopee/pages/map.dart';

class Alimentos extends StatefulWidget {
  const Alimentos({super.key});

  @override
  State<Alimentos> createState() => _AlimentosState();
}

class _AlimentosState extends State<Alimentos> {
  final TextEditingController nomeAlimentoController = TextEditingController();
  final TextEditingController quantController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController prazoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 30),
            buildTextFormField(
              controller: nomeAlimentoController,
              text: 'Alimento(s)',
              keyboardType: TextInputType.text,
            ),
            buildTextFormField(
              controller: quantController,
              text: 'Quant.',
              keyboardType: TextInputType.number,
            ),
            buildTextFormField(
              controller: enderecoController,
              text: 'Endereço',
              keyboardType: TextInputType.text,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.deepPurple,
                ),
                onPressed: () async {
                  String endereco = enderecoController.text;
                  if (endereco.isNotEmpty) {
                    List<Location> locations = await locationFromAddress(endereco);
                    if (locations.isNotEmpty) {
                      Location location = locations.first;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage(location: location)),
                      );
                    }
                  }
                },
              ),
            ),
            buildTextFormField(
              controller: prazoController,
              text: 'Prazo',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: onPressed,
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String text,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: fieldValidator,
        decoration: buildInputDecoration(text, suffixIcon),
        cursorColor: Colors.deepPurple,
      ),
    );
  }

  String? fieldValidator(value) {
    if (value == null || value.isEmpty) {
      return "Este campo não pode ser vazio!";
    }
    return null;
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: const Text(
        'Nova Doação',
        style: TextStyle(
          fontSize: 23,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String name, Widget? suffixIcon) {
    return InputDecoration(
      labelText: name,
      floatingLabelStyle: const TextStyle(
        color: Colors.deepPurple,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 2,
          color: Colors.deepPurple,
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }

  Future<void> onPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      String nomeAlimento = nomeAlimentoController.text;
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
          },
        ),
      );
    }
  }
}
