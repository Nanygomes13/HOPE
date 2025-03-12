class DoacaoMateriais {
  late String nome_materiais;
  late int quant;
  late String endereco;
  late String prazo;

  DoacaoMateriais({
    required this.nome_materiais,
    required this.quant,
    required this.endereco,
    required this.prazo,
  });

  DoacaoMateriais.fromJson(Map<String, dynamic> json) {
    nome_materiais = json['nome_materiais'] ?? '';
    quant = json['quant'] ?? 0;
    endereco = json['endereco'] ?? '';
    prazo = json['prazo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['nome_materiais'] = nome_materiais;
    json['quant'] = quant;
    json['endereco'] = endereco;
    json['prazo'] = prazo;

    return json;
  }
}