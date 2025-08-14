import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(home: ProdutoPage(),));

//class q chama a mudança de estado
class ProdutoPage extends StatefulWidget{
  const ProdutoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProdutoPageState();
  }
  }

  class _ProdutoPageState extends State<ProdutoPage>{
    List<Map<String,dynamic>> _produtos = [];

    final TextEditingController _nomeProdutoController = TextEditingController();
    final TextEditingController _valorProdutoController = TextEditingController();
  
  
  //métodos
  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  //path_provider (permite buscar arquivos do dispositivo local) 
  //instalar o package do path_provider = pub add
  
  Future<File> _getFile() async{
    final dir = await getApplicationDocumentsDirectory();
    return File ("${dir.path}/produtos.jspon");
  }

  void _carregarProdutos() async{
    try{
      final file = await _getFile();
      String JsonProdutos = await file.readAsString();
      List<dynamic> dados = json.decode(JsonProdutos);
      setState(() {
        _produtos = dados.cast<Map<String,dynamic>>();
      });
    } catch (e) {
      _produtos = [];
      print("Erro ao carregar arquivos $e");
    }
  }

  void _salvarProdutos() async{
    try {
      final file = await _getFile();
      String JsonProduto = json.encode(_produtos);
      await file.writeAsString(JsonProduto);
    } catch (e) {
      print("Erro ao salvar Produtos $e");
    }
  }

  void _adicionarProduto() {
    String nome = _nomeProdutoController.text.trim();
    String valorStr = _valorProdutoController.text.trim();
    if(nome.isEmpty || valorStr.isEmpty) return;
    double? valor = double.tryParse(valorStr);
    if(valor == null) return;

    final produto = {"nome":nome, "valor":valor};
    setState(() {
      _produtos.add(produto);
    });
    _nomeProdutoController.clear();
    _valorProdutoController.clear();
    _salvarProdutos();
  }

  void _removerProduto(int index){
    setState(() {
      _produtos.removeAt(index);
    });
    _salvarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Produtos"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(

          children: [
            TextField(
              controller: _nomeProdutoController,
              decoration: InputDecoration(labelText: "Nome do Produto"),
            ),
            TextField(
              controller: _valorProdutoController,
              decoration: InputDecoration(labelText:"Valor do Produto (ex: 15.55)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _adicionarProduto,
               child: Text("Adicionar Produto")),
               Divider(),
               Expanded(
                child: _produtos.isEmpty ?
                Center(child: Text("Nenhum Produto Cadastrado"),) :
                ListView.builder(
                  itemCount: _produtos.length,
                  itemBuilder: (context,index){
                    final produto = _produtos[index];
                    return ListTile(
                      title: Text(produto["nome"]),
                      subtitle: Text(
                        "R\$ ${produto["valor"]}",
                      ),
                      trailing: IconButton(
                        onPressed: () => _removerProduto(index),
                        icon: Icon(Icons.delete)),
                    );
                  })
                
                ),
          ],
        )
        )
    );
  }
  }