class Livro {
  final String? id;
  final String titulo;
  final String autor;
  final bool disponivel;

  Livro({this.id, required this.titulo, required this.autor, this.disponivel = true});

  Map<String,dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "autor": autor,
    "disponivel": disponivel,
  };

  factory Livro.fromJson(Map<String,dynamic> json) =>
  Livro(
    id: json["id"].toString(),
    titulo: json["titulo"].toString(),
    autor: json["autor"].toString(),
    disponivel: json["disponivel"].bool(),
  );
}  