import 'package:exemplo_gps/clima_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatefulWidget{
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>{
  String mensagem = "";

  Future<String?> _getLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return "Serviço de Localização está Desativado";
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return "Permissão de Localização Negada";
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    try {
      final cidade = await ClimaService.getCityWeatherByPosition(position);
    return "${cidade["name"]} -- ${cidade["main"]["temp"] - 273}° ";
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //chama o método antes de buildar a tela
    String result = _getLocation().toString();
    setState(() {
      mensagem = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(
              onPressed: () async{
                String? result = await _getLocation();
                setState(() {
                  mensagem = result!;
                });
              },
              child: Text("Pegar a Localização"))
          ],
        ),
      ),
    ) ;
  }
}