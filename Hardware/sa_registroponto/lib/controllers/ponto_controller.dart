import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ponto_model.dart';

class PontoController {
  final _db = FirebaseFirestore.instance;

  Future<void> registrarPonto(PontoModel ponto) async {
    await _db.collection('pontos').add(ponto.toMap());
  }
}