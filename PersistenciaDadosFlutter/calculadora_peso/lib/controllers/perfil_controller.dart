import '../models/perfil_model.dart';

class PerfilController {
  final CalculadoraPesoDBHelper _dbHelper = CalculadoraPesoDBHelper();

  Future<int> createPerfil(Perfil perfil) async {
    return _dbHelper.insertPerfil(perfil);
  }

  Future<List<Perfil>> readPerfil() async {
    return _dbHelper.getPerfil();
  }

  Future<int> updatePerfil(int perfil) async {
    return _dbHelper.//updatePerfil(perfil);
  
  }
  Future<int> deletePerfil(int nome) async {
    return _dbHelper.deletePerfil(nome);
  }

  
}
