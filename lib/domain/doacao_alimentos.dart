class DoacaoAlimentos {
  late String nome_alimento;
  late int quant;
  late String endereco;
  late String prazo;

  DoacaoAlimentos({
    required this.nome_alimento,
    required this.quant,
    required this.endereco,
    required this.prazo,
  });

  DoacaoAlimentos.fromJson(Map<String, dynamic> json) {
    nome_alimento = json['nome_alimento'] ?? '';
    quant = json['quant'] ?? 0;
    endereco = json['endereco'] ?? '';
    prazo = json['prazo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['nome_alimento'] = nome_alimento;
    json['quant'] = quant;
    json['endereco'] = endereco;
    json['prazo'] = prazo;

    return json;
  }
}
