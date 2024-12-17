class Transacao {
  int? id;
  String nome;
  String instituicao;
  double valor;
  String pix;
  String data;
  String hora;

  Transacao({
    this.id,
    required this.nome,
    required this.instituicao,
    required this.valor,
    required this.pix,
    required this.data,
    required this.hora,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'instituicao': instituicao,
      'valor': valor,
      'pix': pix,
      'data': data,
      'hora': hora,
    };
  }

  Transacao.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'],
        instituicao = map['instituicao'],
        valor = map['valor'],
        pix = map['pix'],
        data = map['data'],
        hora = map['hora'];
}
