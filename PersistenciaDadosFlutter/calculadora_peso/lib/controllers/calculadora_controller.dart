import '../model/peso_model.dart';
import '../model/perfil_model.dart';

class CalculadoraController {
  double calcularIMC(Perfil perfil, Peso peso) {
    final altura = double.tryParse(perfil.altura);
    if (altura == null || altura == 0) return 0;
    return peso.valor / (altura * altura);
  }
}
