class PontoModel {
  final String userId;
  final DateTime dateTime;
  final double latitude;
  final double longitude;

  PontoModel({
    required this.userId,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap(){
    return {
      'userId': userId,
      'dateTime': DateTime.now().toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}