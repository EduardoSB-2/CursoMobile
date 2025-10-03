import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class MapController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //Método para pegar a geolocalização do ponto
  Future<LocationPoints> getcurrentLocation() async {
    //Solicitar permissão de localização
    //Liberar permissões
    //Verificar se o serviço de localização está ativo
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission;
    //Verificar permissão de uso do GPS
    permission = await Geolocator.checkPermission();
    //Por padrão todo novo aplicativo começa com a permissão negada
    if (permission == LocationPermission.denied) {
      //Solicitar permissão
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão Negada de Acesso ao GPS");
      }
    }
    // Acesso foi Liberado
    Position position = await Geolocator.getCurrentPosition();
    String dataHora = _formatar.format(DateTime.now());
    LocationPoints posicaoAtual = LocationPoints(
      latitude: position.latitude,
      longitude: position.longitude,
      timeStamp: dataHora,
    );

    //Devolve o obj
    return posicaoAtual;
  }
}
