import 'dart:io';
import 'package:atividade_exemplo/controllers/foto_controller.dart';
import 'package:atividade_exemplo/models/foto_model.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  List<PhotoModel> _photos = [];
  final _photoController = PhotoController();
  bool _isLoading = false;

  Future<void> _takePhoto() async {
    setState(() {
      _isLoading = true;
    });
    try {
      PhotoModel photo = await _photoController.getImageAndLocation();
      setState(() {
        _photos.add(photo);
      });
    } catch (e) {
      print("Erro ao obter imagem ou localização: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picker")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _photos.isEmpty
              ? Center(child: Text("Nenhuma Imagem Selecionada"))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _photos.length,
                  itemBuilder: (context, index) {
                    final photo = _photos[index];
                    return GestureDetector(
                      onTap: () {
                        _showImageDetails(photo);
                      },
                      child: photo.photoPath != null
                          ? Image.file(File(photo.photoPath!), fit: BoxFit.cover)
                          : Placeholder(), // Placeholder if no image
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        tooltip: 'Tirar Foto',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void _showImageDetails(PhotoModel photo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Detalhes da Imagem"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              photo.photoPath != null
                  ? Image.file(File(photo.photoPath!), height: 200, width: 200, fit: BoxFit.cover)
                  : SizedBox.shrink(),
              SizedBox(height: 10),
              Text(photo.dateTime != null ? "Data/Hora: ${photo.dateTime}" : "Data/Hora não disponível"),
              Text(photo.position != null
                  ? "Localização: ${photo.position!.latitude}, ${photo.position!.longitude}"
                  : "Localização não disponível"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }
}