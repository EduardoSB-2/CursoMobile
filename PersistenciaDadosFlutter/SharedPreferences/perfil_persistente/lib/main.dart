import 'package:flutter/material.dart';
import 'package:perfil_persistente/tela_inicial.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => TelaInicial()
      },
    ));
}
