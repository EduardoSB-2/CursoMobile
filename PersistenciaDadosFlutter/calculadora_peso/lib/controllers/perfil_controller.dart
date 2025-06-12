import 'package:calculadora_peso/services/calculadora_dbhelper.dart';
import '../models/perfil_model.dart';

class PerfilController {
  final CalculadoraDBHelper _dbHelper = CalculadoraDBHelper();

  Future<int> createPerfil(Perfil perfil) async {
    return _dbHelper.insertPerfil(perfil);
  }

  Future<List<Perfil>> readPerfil() async {
    return _dbHelper.getPerfil();
  }

  Future<Perfil> updatePerfil(Perfil perfil) async {
    return _dbHelper.updatePerfil(perfil);
  
  }
  Future<int> deletePerfil(String nome) async {
    return _dbHelper.deletePerfil(nome);
  }
  
}