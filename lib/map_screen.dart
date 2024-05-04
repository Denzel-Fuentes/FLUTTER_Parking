import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

const String MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';
const String MAPBOX_STYLE = 'mapbox/streets-v12';


class MapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map App',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;
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
        myPosition = LatLng(position.latitude, position.longitude);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPosition == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: myPosition,
                zoom: 18,
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
                MarkerLayer(
                  markers: [
                    Marker(
                      point: myPosition!,
                      width: 30,
                      height: 30,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
