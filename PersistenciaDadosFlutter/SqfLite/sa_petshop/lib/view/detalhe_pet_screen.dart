import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';

class DetalhePetScreen extends StatefulWidget {
  final int petId; //receber o PetId -> atributo

  //construtor
  const DetalhePetScreen({super.key, required this.petId});

  @override
  State<StatefulWidget> createState() {
    return _DetalhePetScreenState();
  }
}

class _DetalhePetScreenState extends State<DetalhePetScreen> {
  final PetController _petController = PetController();
  final ConsultaController _consultaController = ConsultaController();

  bool _isLoading = true;

  Pet? _pet; // pode inicialmente ser nulo

  List<Consulta> _consultas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarDados();
  }

  _carregarDados() {
    setState(() async {
      _isLoading = true;
      try {
        _pet = await _petController.readPetById(widget.petId);
        _consultas = await _consultaController.readConsultaForPet(widget.petId);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Exception: ${e}")));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe do Pet"),),
      body: _isLoading
      ? Center(child: CircularProgressIndicator(),)
      : _pet==null
      ? Center(child: Text("Erro ao Carregar Pet"),)
    )
  }
}
