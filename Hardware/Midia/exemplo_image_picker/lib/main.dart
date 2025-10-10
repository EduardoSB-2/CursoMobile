import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(MaterialApp(home: ImagePickerScreen(),));
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  //Usar a biblioteca image_picker
  //Para poder manipular o arquivo
  File? _image;
  final _picker = ImagePicker();

  //Método para tirar foto
  void _getImageFromCamera() async{
    //abrir a camera e permitir tirar uma foto
    //armazena a foto em um aquivo temporario(pickedFile)
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    //verificar se a imagem foi salva no arquivo temporario
    if(pickedFile != null){
      setState(() {
        //coloco a image(imagem) dentro do meu aplicativo
        _image = File(pickedFile.path);
      });
    }
  }


  void _getImageFromGallery() async{
    //abrir a galeria
    //armazena a foto em um aquivo temporario(pickedFile)
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //verificar se a imagem foi salva no arquivo temporario
    if(pickedFile != null){
      setState(() {
        //coloco a image(imagem) dentro do meu aplicativo
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picker"),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //campo para adicionar a imagem => ternário
          _image != null
          ? Image.file(_image!, height: 300,)
          : Text("Nenhuma Imagem Selecionada"),
          //Colocar dois botões
          SizedBox(height: 20,),
          ElevatedButton(onPressed: _getImageFromCamera, child: Text("Tirar Foto")),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: _getImageFromGallery, child: Text("Escolher da Galeria"))
        ],
      ),),
    );
  }
}