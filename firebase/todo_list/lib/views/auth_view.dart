import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/views/login_view.dart';
import 'package:todo_list/views/tarefas_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context, snapshot){
        if(snapshot.hasData){
          return TarefasView();
        }
        return LoginView();
       });
    }
}