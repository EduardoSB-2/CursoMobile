import 'package:biblioteca_app/models/user.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController{
  Future<List<Usuario>> fetchAll() async {
    final list = await ApiService.getList("usuarios?_sort=nome");
    return list.map((item) => Usuario.fromJson(item)).toList();
  }
  Future<Usuario> fetchOne(String id) async{
    final usuario = await ApiService.getOne("usuario", id);
    return Usuario.fromJson(usuario);
  }
}