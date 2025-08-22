class Clima {
  final String nome;
  final double temperatura;
  final String descricao;

  Clima({
    required this.nome,
    required this.temperatura,
    required this.descricao,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      nome: json['name'],
      temperatura: json['main']['temp'],
      descricao: json['weather'][0]['description'],
    );
  }
}