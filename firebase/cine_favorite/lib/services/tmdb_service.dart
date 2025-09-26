//Meu serviço de conexão com a API

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService {
  //Dados da API
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";
  //Static -> atributos da classe e não do OBJ

  //método para buscar filme com base no texto (static) -> método que será executado pela Classe e não pelo OBJ
  static Future<List<Map<String,dynamic>>> searchMovies(String query) async{
    //Converter String em URL
    final apiUrl = Uri.parse("$_baseUrl/search/movie?api_key=$_apiKey&query=$query&language=$_idioma");
    //http.get
    final response = await http.get(apiUrl);

    //se resposta for ok == 200
    if(response.statusCode ==200){
      final data = json.decode(response.body);
      return List<Map<String,dynamic>>.from(data["results"]);
    }else{
      //caso contrario - cria uma exception
      throw Exception("Falha ao carregar filmes da API");
  }
  }

  //Método de busca de filme pleo ID
}