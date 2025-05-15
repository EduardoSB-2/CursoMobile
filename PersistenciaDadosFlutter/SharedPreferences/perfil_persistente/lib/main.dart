import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){ 
 runApp(MaterialApp( 
  home: TelaInicial(),
 ));
}

class TelaInicial extends StatefulWidget{
  @override
  State<TelaInicial> createState()=> _TelaInicialState(); 
}

class _TelaInicialState extends State<TelaInicial>{
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();

  String? _nome; 
  String ?_idade;

  String? _cor;
  Color _corFundo = Colors.white; 

  Map<String,Color> coresDisponiveis={
    "Branco": Colors.white,
    "Preto": Colors.black,
    "Vermelho": Colors.red,
    "Verde": Colors.green,
    "Azul": Colors.blue,
    "Amarelo": Colors.yellow,
    "Rosa": Colors.pink,
    "Laranja": Colors.orange,
    "Cinza": Colors.grey,
    "Roxo": Colors.purple,
  };


  
  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  _carregarPreferencias() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() { 
      _nome = _prefs.getString("nome");
      _idade = _prefs.getString("idade");
      _cor = _prefs.getString("cor");
      if(_cor != null){
        _corFundo = coresDisponiveis[_cor!]!;
      }
    });
  }

  _salvarPreferencias() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _nome = _nomeController.text.trim();
    _idade = _idadeController.text.trim();
    _corFundo = coresDisponiveis[_cor!]!;
    await _prefs.setString("nome", _nome ?? "");
    await _prefs.setString("idade", _idade ?? "");
    await _prefs.setString("cor", _cor ?? "Branco");
    setState(() {
      
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(title: Text("Meu Perfil", 
          style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white ),),
        backgroundColor: _corFundo,),
      body: Padding(padding: EdgeInsets.all(16), child: ListView(
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: _idadeController,
            decoration: InputDecoration(labelText: "Idade"),
          ),
          SizedBox(height: 16,),
          DropdownButtonFormField(
            value: _cor,
            decoration: InputDecoration(labelText: "Cor Favorita"),
            items: coresDisponiveis.keys.map(
              (cor){
                return DropdownMenuItem(
                  value: cor,
                  child: Text(cor));
              }
            ).toList(), 
            onChanged: (valor){
              setState(() {
                _cor = valor;
              });
            }),
          SizedBox(height: 16,),
          ElevatedButton(onPressed: _salvarPreferencias, child: Text("Salvar Perfil")),
          SizedBox(height: 16,),
          Divider(),
          Text("Dados do Usuário:"),
          if(_nome !=null)
            Text("Nome: $_nome",style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white )),
          if(_idade !=null)
            Text("Idade: $_idade",style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white )),
            
        ],
      ),),
    );
  }

}