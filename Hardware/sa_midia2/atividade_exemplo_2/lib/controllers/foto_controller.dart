import 'dart:convert';
import 'dart:io';
import 'package:atividade_exemplo_2/models/foto_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PhotoController {
  //método para pegar a photo no dispositivo,
  // pegar o geolocalização, pegar a data e a patir da 
  //geolocalização determinar a cidade onde a foto foi tirada
  //vai retronar um obj da classe model
  Future<PhotoModel> photoWithLocation() async{
    //instalar as bibliotecas (geolocator, http, image_picker, intl, )
    final _picker = ImagePicker();
    String photoPath = "";
    String _apiKey = "MinhaChaveAPi";
    String cityName = "";

    //verificar a geolocalização
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      throw Exception("Serviço de Localização desabilitado");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception("Permissão Negada");
      }
    }
    //permissão liberada pegar localização
    Position position = await Geolocator.getCurrentPosition();
    //pegar a imagem
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if( pickedFile == null){
      throw Exception("Imagem não Adicionada");
    }
    photoPath = File(pickedFile.path).toString();
    //conecta com API para buscar informações da localização a parit da latitude e longitude
    final result = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?apiid=$_apiKey&lat=${position.latitude}&lon=${position.longitude}"
      )
    );
    //verificar o result
    if(result.statusCode!=200){
      throw Exception("Localização Não Encontrada");
    }
    Map<String,dynamic> data = jsonDecode(result.body);
    cityName = data["name"];
    //Criar o OBJ
    PhotoModel photo = PhotoModel(
      location: cityName, 
      dateTime: DateTime.now().toString(), //converte para Data Local(BR)
      photoPath: photoPath);

    return photo;

  }
}