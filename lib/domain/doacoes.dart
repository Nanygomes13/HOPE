class Doacoes {
  late int id;
  late String imagem;
  String? titulo;
  String? subtitulo;
  String? valor;

  Doacoes({
    required this.imagem,
    this.titulo,
    this.subtitulo,
    this.valor,
  });

  Doacoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagem = json['imagem'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['imagem'] = imagem;
    json['titulo'] = titulo;
    json['subtitulo'] = subtitulo;
    json['valor'] = valor;

    return json;
  }
}
