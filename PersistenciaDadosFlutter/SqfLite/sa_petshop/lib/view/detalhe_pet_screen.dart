import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/view/agenda_consulta_screen.dart';

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

  _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
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
      : Padding(
        padding: EdgeInsets.all(16),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${_pet!.nome}", style: TextStyle(fontSize: 20 ),),
            Text("Raça: ${_pet!.raca}"),
            Text("Dono: ${_pet!.nomeDono}"),
            Text("Telefone: ${_pet!.telefoneDono}"),
            Divider(),
            Text("Consultas:", style: TextStyle(fontSize: 20),),
            _consultas.isEmpty
            ? Center(child: Text("Não existe Agendamento para o pet"),)
            :Expanded(child: ListView.builder(
           itemCount: _consultas.length,
                    itemBuilder: (context,index){
                      final consulta = _consultas[index]; //elemento da lista
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(consulta.tipoServico),
                          subtitle: Text(consulta.dataHoraFormatada),
                          trailing: IconButton(onPressed: () => _deleteConsulta(consulta.id!),
                          icon:Icon(Icons.delete,color: Colors.red,))
                        ),
                      );
                    }))
              ],
            ) 
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AgendaConsultaScreen(petId: widget.petId)))),
    );
  }

  void _deleteConsulta(int consultaId) async{
    try {
      //delete consulta
      await _consultaController.deleteConsulta(consultaId);
      //recarregar a lista de consultas
      await _consultaController.readConsultaForPet(widget.petId);
      //mensagem para o usúario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Consulta deletada com sucesso!"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Expection: $e"))
      );
    }
  }

}

