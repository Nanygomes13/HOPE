import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Destaque extends StatefulWidget {
  const Destaque({super.key});

  @override
  State<Destaque> createState() => _DestaqueState();
}

class _DestaqueState extends State<Destaque> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'DESTAQUES',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      'assets/alimentosDoados.jpg',
                      height: 80,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Alimentos doados à Comunidade Espírita Nosso Lar'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
