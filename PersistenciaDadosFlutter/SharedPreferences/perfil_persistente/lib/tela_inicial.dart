import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  String _nome = "";
  String _idade = "";

  @override
  void initState() {
    //Todo: implement initState
    super.initState();
    _carregarPreferencias();
  }

  _carregarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString("nome") ?? "";
      _idade = _prefs.getString(_nome) ?? "";
    });
  }
}