class Perfil {
  final String nome;
  final String altura;
  final String sexo;
  final String dataNascimento;

  Perfil({
    required this.nome,
    required this.altura,
    required this.sexo,
    required this.dataNascimento,
  });

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "altura": altura,
      "sexo": sexo,
      "data_nascimento": dataNascimento,
    };
  }

  factory Perfil.fromMap(Map<String, dynamic> map) {
    return Perfil(
      nome: map["nome"] as String,
      altura: map["altura"] as String,
      sexo: map["sexo"] as String,
      dataNascimento: map["data_nascimento"] as String,
    );
  }
}
