import '../models/calculadora_model.dart';
import '../models/perfil_model.dart';

class CalculadoraController {
  double calcularIMC(Perfil perfil, Calculadora peso) {
    final altura = double.tryParse(perfil.altura);
    if (altura == null || altura == 0) return 0;
    return peso.valor / (altura * altura);
  }
}