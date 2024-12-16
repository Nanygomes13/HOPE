import 'package:flutter/material.dart';
import 'package:hopee/cadastro.dart';
import 'package:hopee/db/shared_prefs.dart';
import 'package:hopee/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    bool userStatus = await SharedPrefs().getUser();

    if (userStatus) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const cadastro();
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const Tela_entrar();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF233E7D),
      child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Logo-hurb-branca-bg-azul.jpg/440px-Logo-hurb-branca-bg-azul.jpg'),
    );
  }
}