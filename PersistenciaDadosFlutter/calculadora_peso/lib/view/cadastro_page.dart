import 'package:calculadora_peso/view/perfil_page.dart';
import 'package:flutter/material.dart';
import '../controllers/perfil_controller.dart';
import '../models/perfil_model.dart';


class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _alturaController = TextEditingController();
  final _sexoController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  final PerfilController _perfilController = PerfilController();

   @override
  void dispose() {
    _nomeController.dispose();
    _alturaController.dispose();
    _sexoController.dispose();
    _dataNascimentoController.dispose();
    super.dispose();
  }

  Future<void> _salvarPerfil() async {
  if (_formKey.currentState!.validate()) {
    final perfil = Perfil(
      nome: _nomeController.text,
      altura: _alturaController.text,
      sexo: _sexoController.text,
      dataNascimento: _dataNascimentoController.text,
    );
    await _perfilController.createPerfil(perfil);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil salvo com sucesso!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PerfilPage(perfil: perfil),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _alturaController,
                decoration: const InputDecoration(
                  labelText: 'Altura (ex: 1.75)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a altura' : null,
              ),
              TextFormField(
                controller: _sexoController,
                decoration: const InputDecoration(labelText: 'Sexo'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o sexo' : null,
              ),
              TextFormField(
                controller: _dataNascimentoController,
                decoration: const InputDecoration(
                  labelText: 'Data de Nascimento (ex: 01/01/2000)',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a data de nascimento'
                    : null,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dataNascimentoController.text =
                        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarPerfil,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
