import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main(){
  runApp(MaterialApp(home: AcelerometroScreen(),));
}

class AcelerometroScreen extends StatefulWidget {
  const AcelerometroScreen({super.key});

  @override
  State<AcelerometroScreen> createState() => _AcelerometroScreenState();
}

class _AcelerometroScreenState extends State<AcelerometroScreen> {
  List<double>? _acelerometroValues;

  StreamSubscription<AccelerometerEvent>? _acelerometroSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _acelerometroSubscription = accelerometerEventStream().listen((AccelerometerEvent event){
      setState(() {
        _acelerometroValues = <double>[event.x, event.y, event.z];
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acelerometro"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Valores do Acelerômetro"),
            Text("Eixo X: ${_acelerometroValues?[0]}"),
            Text("Eixo y: ${_acelerometroValues?[1]}"),
            Text("Eixo z: ${_acelerometroValues?[2]}"),
          ],
        ),
      ),
    );
  }
}