import 'package:flutter/material.dart';
import '../models/calculadora_model.dart';
import '../services/calculadora_dbhelper.dart';

class RegistrarPesoPage extends StatefulWidget {
  final String perfilNome;
  const RegistrarPesoPage({Key? key, required this.perfilNome}) : super(key: key);

  @override
  State<RegistrarPesoPage> createState() => _RegistrarPesoPageState();
}

class _RegistrarPesoPageState extends State<RegistrarPesoPage> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _dataController = TextEditingController();

  @override
  void dispose() {
    _pesoController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  Future<void> _salvarPeso() async {
    if (_formKey.currentState!.validate()) {
      final peso = Calculadora(
        valor: double.parse(_pesoController.text),
        data: _dataController.text,
        perfilNome: widget.perfilNome,
      );
      await CalculadoraDBHelper().insertPeso(peso);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Peso registrado com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Novo Peso')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _pesoController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o peso' : null,
              ),
              TextFormField(
                controller: _dataController,
                decoration: const InputDecoration(labelText: 'Data da Medição (ex: 12/06/2025)'),
                readOnly: true,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dataController.text =
                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  }
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a data' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarPeso,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}