import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final _mapController = MapController();
  List<LatLng> _meusPontos = [];
  LatLng? _minhaPosicao;

  @override
  void initState() {
    super.initState();
    _pegarMinhaLocalizacao();
  }

  Future<void> _pegarMinhaLocalizacao() async {
    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _minhaPosicao = LatLng(pos.latitude, pos.longitude);
    });
  }

  double _distanciaAteUltimoPonto() {
    if (_meusPontos.isEmpty || _minhaPosicao == null) return 0;
    final ultimo = _meusPontos.last;
    return Geolocator.distanceBetween(
      ultimo.latitude, ultimo.longitude,
      _minhaPosicao!.latitude, _minhaPosicao!.longitude,
    );
  }

  void _adicionarPonto() {
    if (_minhaPosicao == null) return;
    if (_meusPontos.isEmpty || _distanciaAteUltimoPonto() <= 100) {
      setState(() {
        _meusPontos.add(_minhaPosicao!);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ponto adicionado!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você está a mais de 100m do último ponto!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pontos')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _minhaPosicao ?? LatLng(-22.5709, -47.4038),
                initialZoom: 17,
                  onTap: (_, __) => _adicionarPonto(),
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "com.example.sa_registroponto",
                ),
                if (_minhaPosicao != null)
                  MarkerLayer(markers: [
                    Marker(
                      point: _minhaPosicao!,
                      width: 50,
                      height: 50,
                      child: Icon(Icons.person_pin_circle, color: Colors.red, size: 40),
                    ),
                  ]),
                MarkerLayer(
                  markers: _meusPontos.map((ponto) => Marker(
                    point: ponto,
                    width: 40,
                    height: 40,
                    child: Icon(Icons.location_on, color: Colors.blue),
                  )).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _meusPontos.length,
              itemBuilder: (context, index) {
                final ponto = _meusPontos[index];
                return ListTile(
                  leading: Icon(Icons.location_on, color: Colors.blue),
                  title: Text('Lat: ${ponto.latitude.toStringAsFixed(5)}, Lng: ${ponto.longitude.toStringAsFixed(5)}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarPonto,
        child: Icon(Icons.add),
        tooltip: 'Adicionar ponto na minha localização',
      ),
    );
  }
}