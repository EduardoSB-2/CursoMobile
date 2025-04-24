import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
void main() {
  runApp(MaterialApp(
    home: UserNamePage(),
    debugShowCheckedModeBanner: false,
  ));
}
 
class UserNamePage extends StatefulWidget{
  @override
  _UserNamePageState createState() => _UserNamePageState();
}
 
class _UserNamePageState extends State<UserNamePage>{
  TextEditingController _controller = TextEditingController();
  String _nomeSalvo = "";
 
  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }
  void _carregarNomeSalvo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString('nome')?? "";
    });
  }
  void _salvarNome() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", _controller.text);
    _carregarNomeSalvo();
    _controller.clear();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-Vindo ${_nomeSalvo == ""?"Visitante":_nomeSalvo}'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 132, 31, 248),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Digite seu nome: "),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _salvarNome,
              child: Text("Salvar"),
              ),
          ],
        ),
      ),
    );
  }
}
 