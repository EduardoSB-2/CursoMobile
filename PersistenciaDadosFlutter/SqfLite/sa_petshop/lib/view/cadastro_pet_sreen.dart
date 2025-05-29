//formulario de cadatro do pet

import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/view/home_screen.dart';

class CadastroPetScreen extends StatefulWidget{
    @override
    State<StatefulWidget> createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen>{
    final _formKey = GlobalKey<FormState>(); // chave para armazenamento dos valores do formulário 
    final _controllerPet = PetController();

    //atributos do obj
    late String _nome;
    late String _raca;
    late String _nomeDono;
    late String _telefoneDono;


    //Cadastrar pet ( salvar bo BD)
    Future<void> _salvarPet() async{ // Future é uma ação assincrona
    if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();
        final newPet = Pet(
        nome: _nome,
        raca: _raca,
        nomeDono: _nomeDono,
        telefoneDono: _telefoneDono);
        //mandar as info para o BD
        await _controllerPet.createPet(newPet);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeScreen()));

    }

    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text("Novo Pet"),),
            body: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: ListView(
                        children: [
                            TextFormField(
                                decoration: InputDecoration(labelText: "Nome do Pet"),
                                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!!": null,
                                onSaved: (value) => _nome = value!,
                            ),
                            TextFormField(
                                decoration: InputDecoration(labelText: "Raça do Pet"),
                                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!!": null,
                                onSaved: (value) => _raca = value!,
                            ),
                            TextFormField(
                                decoration: InputDecoration(labelText: "Dono do Pet"),
                                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!!": null,
                                onSaved: (value) => _nomeDono = value!,
                            ),
                            TextFormField(
                                decoration: InputDecoration(labelText: "Telefone do Pet"),
                                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!!": null,
                                onSaved: (value) => _telefoneDono = value!,
                            ),
                            ElevatedButton(onPressed: _salvarPet, child: Text("Cadastrar Pet"))
                        ],
                    )
                ),
            ),
        );
        
    }
}