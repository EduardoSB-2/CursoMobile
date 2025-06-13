class Calculadora {
  final double valor;
  final String data;
  final String perfilNome;

  Calculadora({
    required this.valor,
    required this.data,
    required this.perfilNome,
  });

  Map<String, dynamic> toMap() {
    return {
      "valor": valor,
      "data": data,
      "perfil_nome": perfilNome,
    };
  }

  factory Calculadora.fromMap(Map<String, dynamic> map) {
    return Calculadora(
      valor: map["valor"],
      data: map["data"],
      perfilNome: map["perfil_nome"],
    );
  }
}