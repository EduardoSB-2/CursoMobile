import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_registroponto/models/location_points.dart';

class RegistroController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  Future<LocationPoints> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão Negada de Acesso ao GPS");
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    String dataHora = _formatar.format(DateTime.now());
    return LocationPoints(
      latitude: position.latitude,
      longitude: position.longitude,
      timeStamp: dataHora,
    );
  }

  double calcularDistancia(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}