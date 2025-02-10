import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hopee/agradecimento.dart';
import 'package:hopee/materiais_dao.dart';
import 'package:hopee/doacao_materiais.dart';
import 'package:hopee/map_page.dart';

class Materiais extends StatefulWidget {
  const Materiais({super.key});

  @override
  State<Materiais> createState() => _MateriaisState();
}

class _MateriaisState extends State<Materiais> {
  List<DoacaoMateriais> materiais = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    materiais = await MateriaisDao().listarMateriais();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MATERIAIS',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dados da sua doação',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 45),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: 'Calça jeans, ventilador e camisa polo',
                      decoration: InputDecoration(
                        labelText: 'Materias',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      initialValue: '3',
                      decoration: InputDecoration(
                        labelText: 'Quant.',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: 'Arapiraca - AL',
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.location_on, color: Colors.purple),

                    onPressed: () async {

                      String endereco = 'Arapiraca - AL';
                      Location location = await locationFromAddress(endereco).then((locations) => locations.first);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return MapPage(location: location);
                            }
                            ),
                      );
                    },

                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '7 dias úteis',
                decoration: InputDecoration(
                  labelText: 'Prazo',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const agradecimento();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Confirmar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}