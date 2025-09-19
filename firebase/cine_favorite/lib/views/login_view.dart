import 'package:cine_favorite/views/registro_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget{
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  bool _ocultarSenha = true;

  void _signIn() async{
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fallha ao Fazer Login: $e"))
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"), ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _emailField,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
             TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  onPressed: ()=>setState(() {
                    _ocultarSenha = !_ocultarSenha;
                  }),
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off))),
                  obscureText: _ocultarSenha,
             ),
             SizedBox(height: 20,),
             ElevatedButton(
              onPressed: _signIn,
              child: Text("Login")),
              TextButton(
                onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context)=> RegistroView())),
                child: Text("Não tem uam conta? Registre-se Aqui!!!"))
            ],
          ),
           )
      );
  }
}