import 'dart:async';

import 'package:cine_favorite/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //Garante o carregamento dos widgets
  WidgetsFlutterBinding.ensureInitialized();

  //Conectar com o Firebase
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
    title: "Cine Favorite",
    theme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark
    ),
    home: AuthStream(),
  ));
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        //Se o usuário estiver logado, direciona para a tela de filmes favoritos
        if(snapshot.hasData){//Verifica se o snapshot tem algum dado
        //return FavoriteView();
        } //Se não estiver logado, direciona para a tela de login
        return LoginView();
      });
  }
}