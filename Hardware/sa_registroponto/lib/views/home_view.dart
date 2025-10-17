import 'package:flutter/material.dart';
import 'map_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Olá, funcionário!'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Registrar Ponto'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}