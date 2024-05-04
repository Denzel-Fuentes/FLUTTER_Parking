import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

const String MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';
const String MAPBOX_STYLE = 'mapbox/streets-v12';

class RegisterGarage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garage Registration',
      home: RegisterGarageScreen(),
    );
  }
}

class RegisterGarageScreen extends StatefulWidget {
  @override
  _RegisterGarageScreenState createState() => _RegisterGarageScreenState();
}

class _RegisterGarageScreenState extends State<RegisterGarageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _directionsController = TextEditingController();
  List<String> _offers = [];
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error obtaining location: $e'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }
    return Geolocator.getCurrentPosition();
  }

  void _addOffer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _offerController = TextEditingController();
        return AlertDialog(
          title: Text('Añadir Oferta'),
          content: TextField(
            controller: _offerController,
            decoration: InputDecoration(hintText: 'Ingrese la oferta'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _offers.add(_offerController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Garaje'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _directionsController,
                  decoration:
                      InputDecoration(labelText: 'Indicaciones para llegar'),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese las indicaciones';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('Ofertas',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                SizedBox(height: 8.0),
                ..._offers.map((offer) => Text('- $offer')).toList(),
                SizedBox(height: 8.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _addOffer,
                    child: Text('Añadir Oferta'),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Ubicación',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                SizedBox(height: 8.0),
                SizedBox(
                  height: 300.0,
                  child: _selectedLocation == null
                      ? Center(child: CircularProgressIndicator())
                      : Stack(
                          children: [
                            FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                center: _selectedLocation,
                                zoom: 18.0,
                                interactiveFlags: InteractiveFlag.all,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                                  additionalOptions: {
                                    'accessToken': MAPBOX_ACCESS_TOKEN,
                                    'id': MAPBOX_STYLE,
                                  },
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.location_on,
                                  color: Colors.red, size: 40),
                            ),
                            Positioned(
                              top: 10.0,
                              right: 10.0,
                              child: FloatingActionButton(
                                onPressed: () {
                                  _mapController.rotate(0);
                                },
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: Icon(Icons.north),
                                mini: true,
                              ),
                            ),
                            Positioned(
                              bottom: 16.0,
                              right: 16.0,
                              child: Column(
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      _mapController.move(_selectedLocation!,
                                          _mapController.zoom + 1);
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    child: Icon(Icons.add),
                                    mini: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  FloatingActionButton(
                                    onPressed: () {
                                      _mapController.move(_selectedLocation!,
                                          _mapController.zoom - 1);
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    child: Icon(Icons.remove),
                                    mini: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text;
                        String directions = _directionsController.text;
                        List<String> offers = _offers;
                        LatLng location = _selectedLocation!;

                        print('Nombre: $name');
                        print('Indicaciones: $directions');
                        print('Ofertas: $offers');
                        print('Ubicación: $location');
                      }
                    },
                    child: Text('Terminar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
