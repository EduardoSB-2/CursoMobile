import 'package:geolocator/geolocator.dart';

class PhotoModel {
  final String? photoPath;
  final Position? position;
  final String? dateTime;

  PhotoModel({
    this.photoPath,
    this.position,
    this.dateTime,
  });
}