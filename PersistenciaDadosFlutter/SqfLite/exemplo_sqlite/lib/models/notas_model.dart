class Nota {
  int? id;
  String titulo;
  String conteudo;

  Nota({this.id, required this.titulo, required this.conteudo});

  Map<String, dynamic> toMap() => {
    "id": id,
    "titulo": titulo,
    "conteudo": conteudo,
  };

  factory Nota.fromMap(Map<String, dynamic> map) => Nota(
    id: map["id"] as int,
    titulo: map["titulo"] as String,
    conteudo: map["conteudo"] as String,
  );

  @override
  String toString() {
    return "Nota{id: $id, título: $titulo, conteúdo: $conteudo}";
  }
}
