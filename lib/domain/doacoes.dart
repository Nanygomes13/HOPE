class Doacoes {
  late int id;
  late String imagem;
  late String titulo;
  late String subtitulo;
  late double? valor;

  Doacoes({
    required this.imagem,
    required this.titulo,
    required this.subtitulo,
    this.valor,
  });

  Doacoes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    imagem = json['imagem'] ?? '';
    titulo = json['titulo'] ?? '';
    subtitulo = json['subtitulo'] ?? '';
    valor = json['valor'] ?? 0;
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
