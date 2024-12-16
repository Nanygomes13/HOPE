import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hopee/cadastro.dart';
import 'package:hopee/db/shared_prefs.dart';
import 'package:hopee/db/user_dao.dart';
import 'package:hopee/destaque.dart';
import 'package:path/path.dart';

class Tela_entrar extends StatefulWidget {
  const Tela_entrar({super.key});

  @override
  State<Tela_entrar> createState() => _Tela_entrarState();
}

class _Tela_entrarState extends State<Tela_entrar> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  'Bem Vindo de Volta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Faça login em sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87),
                ),
                SizedBox(height: 50),
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
                SizedBox(height: 20),
                Align(
                  child: InkWell(
                    onTap: () {
                      // Ação
                    },
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  alignment: Alignment(0.8, 0),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C4DFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Não tem conta?  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: 'Inscreva-se!',
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
                                    builder: (context) => cadastro()));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

      bool auth = await UserDao().autenticar(email, senha);

      if (auth) {
        SharedPrefs().setUser(true);
        
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) {
              return Destaque();
            },
          ),
        );
      } else {
        print('E-mail e/ou Senha incorreto(s)');
      }
    }
  }
}