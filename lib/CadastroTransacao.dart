import 'package:flutter/material.dart';
import 'package:hopee/transacao.dart';
import 'package:hopee/transacaoDao.dart';

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
  TextEditingController _dataController = TextEditingController();
  TextEditingController _horaController = TextEditingController();


  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      final novaTransacao = Transacao(
        nome: _nomeController.text,
        instituicao: _instituicaoController.text,
        valor: double.tryParse(_valorController.text) ?? 0.0,
        pix: _pixController.text,
        data: _dataController.text,
        hora: _horaController.text,
      );

      await TransacaoDao().salvarTransacao(novaTransacao);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar Transação"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextFormField("Nome", _nomeController),
                _buildTextFormField("Instituição", _instituicaoController),
                _buildTextFormField("Valor", _valorController, isNumeric: true),
                _buildTextFormField("PIX", _pixController),
                _buildTextFormField("Data", _dataController, isReadOnly: true),
                _buildTextFormField("Hora", _horaController, isReadOnly: true),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _saveTransaction,
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextFormField(String label, TextEditingController controller, {bool isNumeric = false, bool isReadOnly = false}) {
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
      readOnly: isReadOnly,
    );
  }
}
