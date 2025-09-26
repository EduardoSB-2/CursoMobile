//Classe de modelagem do OBJ Movie
//Receber os dados da API -> Enviar os dados para o Firestore

class Movie {
  final int id;
  final String title;
  final String posterPath; //Caminho da imagem do Poster
  double rating; //nota do usuário ao filme sendo de 0 a 5

  //construtor
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });

  //métodos de conversão de OBJ <=> JSON
  //ToMap OBJ => JSON
  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "title":title,
      "posterPath":posterPath,
      "rating":rating,
    };
  }

  //fromMap JSON => OBJ
  //fabricando um OBJ a partir da coleção
  factory Movie.fromMap(Map<String,dynamic> map){
    return Movie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble());
  }
}