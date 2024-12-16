import 'package:flutter/material.dart';
import 'package:minhasdoacoes/db/database.dart';
import 'package:minhasdoacoes/main.dart';
import 'package:minhasdoacoes/transacao.dart';
import 'package:intl/intl.dart';

class CadastroTransacao extends StatefulWidget {
  const CadastroTransacao({super.key});

  @override
  State<CadastroTransacao> createState() => _CadastroTransacaoState();
}

class _CadastroTransacaoState extends State<CadastroTransacao> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _instituicaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _pixController = TextEditingController();

  void salvarTransacao() async {
    if (_formKey.currentState!.validate()) {
      final agora = DateTime.now();
      final data = DateFormat('yyyy-MM-dd').format(agora);
      final hora = DateFormat('HH:mm').format(agora);

      final novaTransacao = Transacao(
        nome: _nomeController.text,
        instituicao: _instituicaoController.text,
        valor: double.tryParse(_valorController.text) ?? 0.0,
        pix: _pixController.text,
        data: data,
        hora: hora,
      );

      // Salva no banco de dados
      await DatabaseHelper.instance.insertTransacao(novaTransacao);

      // Retorna à tela anterior
      Navigator.pop(context);
    }
  }

  Widget _buildTextFormField(String label, TextEditingController controller,
      {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira o $label.';
        }
        if (isNumeric && double.tryParse(value) == null) {
          return 'Por favor, insira um número válido.';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "cadastrar transacao",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                _buildTextFormField("Nome", _nomeController),
                _buildTextFormField("Instituição", _instituicaoController),
                _buildTextFormField("Valor", _valorController, isNumeric: true),
                _buildTextFormField("PIX", _pixController),

                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: salvarTransacao,
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
