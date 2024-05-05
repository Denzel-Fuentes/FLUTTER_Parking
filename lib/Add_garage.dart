import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_app/Add_offer.dart';
import 'package:parking_app/Cards/OfferCard.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/Location.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/models/Parking.dart';
import 'package:parking_app/repositories/offer.dart';
import 'package:parking_app/repositories/parking.dart';
import 'package:parking_app/services/repository.dart';

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
  List<Offer> _offers = [];
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();
  List<String> additionalSigns = [];

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

  void _addOffer() async {
    final Offer? newOffer = await showDialog<Offer>(
      context: context,
      builder: (BuildContext context) {
        return AddOfferScreen(
          isPreviewMode: true,
        );
      },
    );

    if (newOffer != null)
      setState(() {
        _offers.add(newOffer);
      });
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
                additionalSignsInput(),
/*                 TextFormField(
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
                ), */

                Text('Ofertas',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                SizedBox(height: 8.0),
                showOffers(),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text;
                        String directions = _directionsController.text;
                        LatLng location = _selectedLocation!;

                        print('Nombre: $name');
                        print('Indicaciones: $directions');
                        print('Ubicación: $location');

                        String parkingID = await ParkingRepository().create(
                            Parking(
                                userId: UserManager.getCurrentUser!.id!,
                                name: name,
                                additionalSigns: additionalSigns,
                                location: Location(coordinates: <double>[
                                  location.latitude,
                                  location.longitude
                                ])));

                        for (Offer offer in _offers) {
                          OfferRepository().create(Offer(
                              parkingId: parkingID,
                              price: offer.price,
                              description: offer.description,
                              title: "",
                              high: offer.high,
                              wide: offer.wide,
                              long: offer.long,
                              state: offer.state,
                              type: offer.type));
                        }
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

  Widget additionalSignsInput() {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String newDirection = '';
                  return AlertDialog(
                    title: Text('Nueva Indicación'),
                    content: TextField(
                      onChanged: (value) {
                        newDirection = value;
                      },
                      decoration: InputDecoration(labelText: 'Indicaciones'),
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
                          if (newDirection.isNotEmpty) {
                            addDirection(newDirection);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Agregar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Agregar Indicación'),
          ),
        ),
        SizedBox(height: 16.0),
        Column(
          children: additionalSigns.map((sign) {
            int index = additionalSigns.indexOf(sign);
            return ListTile(
              title: Text('- $sign'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removeDirection(index);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget showOffers() {
    return Column(
      children: _offers.map((offer) {
        int index = _offers.indexOf(offer);
        return OfferCard(
            offer: offer,
            showDeleteIcon: true,
            onDelete: () {
              setState(() {
                _offers.removeAt(index);
              });
            });
      }).toList(),
    );
  }

  void addDirection(String direction) {
    setState(() {
      additionalSigns.add(direction);
    });
  }

  void removeDirection(int index) {
    setState(() {
      additionalSigns.removeAt(index);
    });
  }
}
