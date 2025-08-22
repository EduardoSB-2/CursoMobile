class Usuario {
  final String? id;
  final String nome;
  final String email;

  Usuario({this.id, required this.nome, required this.email});

  Map<String,dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "email": email
  };

  factory Usuario.fromJson(Map<String,dynamic> json) =>
  Usuario(
    id: json["id"].toString(),
    nome: json["nome"].toString(),
    email: json["email"].toString()
  );
}