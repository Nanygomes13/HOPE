import 'package:flutter/material.dart';

class TelaBuscar extends StatefulWidget {
  const TelaBuscar({super.key});

  @override
  State<TelaBuscar> createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 240, 205, 243),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.deepPurpleAccent,
                    ),
                    hintText: 'Pesquisar',
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Expanded(
                child: Image.asset(
                  'images/busca.png',
                  width: 250,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 15),
            const Center(
              child: Text(
                'Quem você deseja ajudar hoje?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: SizedBox(
                width: 300,
                child: Text(
                  'Digite alguma palavra relacionada à causa que você procura.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
