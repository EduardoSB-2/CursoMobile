import 'package:flutter/material.dart';
import '../models/perfil_model.dart';
import '../models/calculadora_model.dart';
import '../controllers/calculadora_controller.dart';
import '../services/calculadora_dbhelper.dart';
import '../view/registrar_peso.dart';

class PerfilPage extends StatefulWidget {
  final Perfil perfil;
  const PerfilPage({Key? key, required this.perfil}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  List<Calculadora> historicoPesos = [];
  double? imcAtual;

  @override
  void initState() {
    super.initState();
    _carregarHistorico();
  }

  Future<void> _carregarHistorico() async {
    final db = CalculadoraDBHelper();
    final pesos = await db.getPesosPerfil(widget.perfil.nome);
    setState(() {
      historicoPesos = pesos;
      if (pesos.isNotEmpty) {
        imcAtual = CalculadoraController().calcularIMC(widget.perfil, pesos.last);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.perfil.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Altura: ${widget.perfil.altura} m'),
            Text('Sexo: ${widget.perfil.sexo}'),
            Text('Data de Nascimento: ${widget.perfil.dataNascimento}'),
            const SizedBox(height: 16),
            Text(
              'IMC Atual: ${imcAtual != null ? imcAtual!.toStringAsFixed(2) : 'Sem registro de peso'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text('Histórico de Pesos:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            historicoPesos.isEmpty
                ? const Text('Nenhum peso registrado.')
                : Column(
                    children: historicoPesos
                        .map((peso) => ListTile(
                              title: Text('${peso.valor} kg'),
                              subtitle: Text('Data: ${peso.data}'),
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
      // ...existing code...
floatingActionButton: FloatingActionButton(
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrarPesoPage(perfilNome: widget.perfil.nome),
      ),
    );
    await _carregarHistorico();
  },
  child: const Icon(Icons.add),
  tooltip: 'Registrar novo peso',
),
    );
  }
} 