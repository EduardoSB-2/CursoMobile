import 'dart:io';
import 'package:atividade_exemplo/models/foto_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PhotoController {
  Future<PhotoModel> getImageAndLocation() async {
    final _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return PhotoModel(); // Return an empty PhotoModel if no image is picked
    }

    File image = File(pickedFile.path);
    Position? position = await _getCurrentLocation();
    String? dateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());

    return PhotoModel(
      photoPath: image.path,
      position: position,
      dateTime: dateTime,
    );
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permissão de localização negada.");
        return null;
      }
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Erro ao obter localização: $e");
      return null;
    }
  }
}