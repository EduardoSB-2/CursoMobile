import 'package:atividade_exemplo_2/models/foto_model.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  List<PhotoModel> photos = [];
  

  // método para tirar a Photo
  void TakePhoto() async{
    //criar o método
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              //chamar o método para tirar a foto com localização
            },
          ),
        ],
      ),
      body: //constroi o GRID VIEW,
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //mostrar a foto em tela cheia com a localização
            },
            child: Image.file(
              //pega o caminho da foto e mostra na tela
              photos[index].photoPath,//converte para file
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}