class Peso {
  final //double valor;
  final String data; // formato: yyyy-MM-dd

  Peso({required this.valor, required this.data});

  Map<String, dynamic> toMap() {
    return {
      "valor": valor,
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
