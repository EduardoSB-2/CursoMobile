<<<<<<< HEAD
class Calculadora {
  final double valor;
  final String data;
  final String perfilNome;

  Calculadora({
    required this.valor,
    required this.data,
    required this.perfilNome,
    });
=======
class Peso {
  final //double valor;
  final String data; // formato: yyyy-MM-dd

  Peso({required this.valor, required this.data});
>>>>>>> e4aa95db5fb3492febab59b1a51af575f144b4df

  Map<String, dynamic> toMap() {
    return {
      "valor": valor,
<<<<<<< HEAD
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
=======
      "data": data,
    };
  }

  factory Peso.fromMap(Map<String, dynamic> map) {
    return Peso(
      valor: map["valor"],
      data: map["data"],
    );
  }
}
}
>>>>>>> e4aa95db5fb3492febab59b1a51af575f144b4df
