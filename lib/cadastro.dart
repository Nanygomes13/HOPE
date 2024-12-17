import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hopee/db/user_dao.dart';
import 'package:hopee/domain/user.dart';
import 'package:hopee/login.dart';

class cadastro extends StatefulWidget {
  const cadastro({super.key});

  @override
  State<cadastro> createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController confirmSenhaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 150),
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Criar uma conta',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Inscreva-se para começar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo Nome obrigatório.';
                  } else {
                    return null;
                  }
                },
                cursorColor: const Color(0xFF7C4DFF),
                decoration: buildInputDecoration(
                  'Nome',
                  Icons.person,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo e-mail obrigatório.';
                  } else if (value.contains('@')) {
                    return null;
                  } else {
                    return 'Você precisa de um e-mail válido.';
                  }
                },
                cursorColor: const Color(0xFF7C4DFF),
                decoration: buildInputDecoration(
                  'E-mail',
                  Icons.mail_outline_outlined,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              TextFormField(
                controller: telefoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.length >= 14) {
                    return null;
                  } else if (value.contains('(), -')) {
                    return 'Você precisa de um telefone válido.';
                  }
                },
                cursorColor: const Color(0xFF7C4DFF),
                decoration: buildInputDecoration(
                  'Telefone',
                  Icons.phone,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                validator: (value) {
                  if (value!.length >= 6) {
                    return null;
                  } else {
                    return 'Você precisa de uma senha válida.';
                  }
                },
                cursorColor: const Color(0xFF7C4DFF),
                decoration: buildInputDecoration(
                  'Senha',
                  Icons.lock_outline,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                controller: confirmSenhaController,
                validator: (value) {
                  String senha = senhaController.text;
                  if (value!.length < 6) {
                    return "Você precisa digitar uma senha válida!";
                  } else if (value != senha) {
                    return "As senhas precisam ser iguais!";
                  } else {
                    return null;
                  }
                },
                decoration: buildInputDecoration(
                  'Confirmação de Senha',
                  Icons.lock_outline,
                ),
                cursorColor: const Color(0xFF10397B),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C4DFF),
                        minimumSize: Size(210, 50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Inscreva-se',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ],
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Já tem uma conta?  ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Entre!',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tela_entrar(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  buildInputDecoration(String label, IconData iconData) {
    return InputDecoration(
      prefixIcon: Icon(
        iconData,
        color: Colors.deepPurpleAccent,
      ),
      labelText: label,
      floatingLabelStyle: const TextStyle(
        color: Colors.deepPurpleAccent,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2,
        ),
      ),
    );
  }

  Future<void> onPressed() async {

    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String senha = senhaController.text;

      User user = User(email, senha);
      UserDao().saveUser(user);
      Navigator.pop(context);
    }
  }
}
