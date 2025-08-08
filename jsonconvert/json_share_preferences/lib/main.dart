import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  bool temaEscuro = false;
  String nomeUsuario = "";

  @override
  void initState() {
    super.initState();
    carregarPreferencias(); 
  }

  void carregarPreferencias() async{
    //conecta com as shared preferences e busca as informações armazenadas
    final prefs = await SharedPreferences.getInstance();
    //recupera as informações do SharedPref e armazena como String (JSON)
    String? jsonString = prefs.getString('config');
    if(jsonString != null){
      //Transformo Json em MAP - decode
      Map<String,dynamic> config = json.decode(jsonString);
      setState(() {
        //pega as informações de acordo com a chave armazenada
        temaEscuro = config['temaEscuro'] ?? false;
        nomeUsuario = config['nome'] ?? "";
      });
    }
  }


@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configurações",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage()
    );
  }
}