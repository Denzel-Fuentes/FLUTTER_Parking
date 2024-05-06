import 'package:flutter/material.dart';
import 'package:parking_app/Add_garage.dart'; // Ensure this is the correct import for your RegisterGarageScreen
import 'package:parking_app/Cards/ParkingCard.dart';
import 'package:parking_app/ParkingDetails.dart';
import 'package:parking_app/context/Garage.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/Parking.dart';
import 'package:parking_app/repositories/parking.dart';

class ListGaragesScreen extends StatefulWidget {
  @override
  _ListGaragesScreenState createState() => _ListGaragesScreenState();
}

class _ListGaragesScreenState extends State<ListGaragesScreen> {
  List<Parking> parkings = []; 

  @override
  void initState() {
    super.initState();
    loadParkings();
  }

  Future<void> loadParkings() async {
    List<Parking> loadedParkings = await ParkingRepository()
        .getAllByField('user', UserManager.getCurrentUser!.id!);
    setState(() {
      parkings = loadedParkings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garages'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (parkings.isEmpty) 
              Column(
                children: [
                  Text(
                    'Aún no tienes garages registrados',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterGarageScreen(),
                  ),
                );
              },
              child: Text('Añadir Garage'),
            ),
            if (parkings
                .isNotEmpty)
              Expanded(
                child: ListView(
                  children: parkings
                      .map((parking) => ParkingCard(
                            parking: parking,
                            onTap: () {
                              ParkingManager.setCurrentParking(parking);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ParkingDetails()));
                            },
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
