import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';

void main() {
  runApp(MaterialApp(home: TarefasPage(),));
}

class TarefasPage extends StatefulWidget{
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

class _TarefasPageState extends State<TarefasPage> {
  List<Map<String,dynamic>> _tarefas = [];
  
  final TextEditingController _tarefaController = TextEditingController();
  //Endereço da API
  final String baseUrl = "http://10.109.197.30:3015/tarefas";

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  void _carregarTarefas() async{
    try{
      //fazer conexão via http
      final response = await http.get(Uri.parse(baseUrl)); //converte Str -> Endereço URL
      if(response.statusCode == 200){
        List<dynamic> dados = json.decode(response.body);
        setState(() {
          _tarefas = dados.map((item)=> Map<String,dynamic>.from(item)).toList(); // Jeito mais correto
          // _tarefas = dados.cast<Map<String,dynamic>>(); // Jeito mais rapido
          // _tarefas = List<Map<String,dynamic>>.from(dados); // Jeito mais direto
        });
      }
    } catch (e) {
      print("Erro ao carregar API: $e");
    }
  }

  void _adicionarTarefa(String titulo) async{
    try{
      // cria um objeto -> tarefa
      final tarefa = {"titulo":titulo, "concluida":false};
      // faz o post http
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(tarefa) //converte de dart -> json
      );
         if(response.statusCode == 201){
          //setState(() {
          _tarefaController.clear();
          _carregarTarefas();
          //});
         }
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
    }
  }

  //remover tarefas
  void _removerTarefa(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if(response.statusCode == 200){
        //setState(() {
          _carregarTarefas();
        //});
      }
    }catch (e) {
      print("Erro ao deletar tarefa $e");
    }
  }


  //attualizar

  void _atualizarTarefa(String titulo) async{
    try{
      final tarefa = {"titulo":titulo, "concluida":!false};
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: {"Content-Type":"applicattion/json"},
        body: json.encode(tarefa)
       );
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }





  //bluid tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via API"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder()
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10,),
            Expanded(
              child: _tarefas.isEmpty
              ? Center(child: Text("Nenhuma tarefa Cadastrada"),)
              : ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index){
                  final tarefa = _tarefas[index];
                  return ListTile(
                    //leading para criar um checkbox(atualizar)
                    leading: Checkbox(
                      value: tarefa[concluida]),



                    title: Text(tarefa["titulo"]),
                    subtitle: Text(tarefa["concluida"] ? "Concluída" :"Pendente"),
                    trailing: IconButton(
                      onPressed: ()=> _removerTarefa(tarefa["id"]),
                       icon: Icon(Icons.delete)),                  
                  );
                })
                )
          ],
        ),
        ),
    );
  }
}