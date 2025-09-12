import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget{
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  final _db = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  final _tarefasField = TextEditingController();

  //métodos

  //adicionar tarefa
  void _addTarefa() async{
    if(_tarefasField.text.trim().isEmpty) return; //Não continua se o campo de tarefa for null
  //add tarefa
  try{
    await _db.collection("usuarios")
              .doc(_user!.uid)
              .collection("tarefas")
              .add({
                "titulo":_tarefasField.text.trim(),
                "concluida":false,
                "dataCriacao":Timestamp.now()
  });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erro ao Add Tarefas $e"))
    );
  }
  }

  //atualizar tarefa
  void _atualizarTarefa(String id, bool statusAtual) async {
    try{
      await _db.collection("usuarios")
                .doc(_user!.uid)
                .collection("tarefas")
                .doc(id)
                .update({
                  "concluida":!statusAtual
                });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Atualizar Tarefa $e"))
      );  
    }
  }


  //remover tarefa
  void _deletarTarefa(String tarefaId) async{
    try{
      await _db.collection("usuarios")
                .doc(_user!.uid)
                .collection("tarefas")
                .doc(tarefaId)
                .delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Deletar Tarefa $e"))
      );
    }
  }

//bluid da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout))
        ],
      ),
      //body das tarefas
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _tarefasField,
            decoration: InputDecoration(
              labelText: "Nova Tarefa",
              border: OutlineInputBorder(),
              suffix: IconButton(
                onPressed: _addTarefa,
                 icon: Icon(Icons.add))
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.collection("usuarios")
                         .doc(_user?.uid)
                         .collection("tarefas")
                         .orderBy("dataCriacao", descending: true).snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){

                }
                if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return Center(child: Text("Nenhuma Tarefa Encontrada"),);
                }
                final tarefas = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (context, index){
                    final tarefa = tarefas[index];
                    final tarefaMap = tarefa.data() as Map<String, dynamic>;
                    bool concluida = tarefaMap["concluida"] ?? false;
                    return ListTile(
                      title: Text(tarefaMap["titulo"]),
                      leading: Checkbox(
                        value: concluida,
                        onChanged: (value)=> _atualizarTarefa(tarefa.id, concluida),
                      ),
                      trailing: IconButton(
                        onPressed: ()=> _deletarTarefa(tarefa.id),
                        icon: Icon(Icons.delete,color: Colors.red,)),
                    );
                  }
                );
              }) )      
        ],
        ),
    ),
    );
  }
}