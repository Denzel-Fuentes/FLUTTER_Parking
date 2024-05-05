import 'package:flutter/material.dart';
import 'package:parking_app/Add_garage.dart'; // Ensure this is the correct import for your RegisterGarageScreen
import 'package:parking_app/Cards/ParkingCard.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/Parking.dart';
import 'package:parking_app/repositories/parking.dart';

class ListGaragesScreen extends StatefulWidget {
  @override
  _ListGaragesScreenState createState() => _ListGaragesScreenState();
}

class _ListGaragesScreenState extends State<ListGaragesScreen> {
  List<Parking> parkings = []; // Initial empty list

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
            if (parkings.isEmpty) // Display message only if no parkings
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
              // Button is always available
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
                .isNotEmpty) // Display list of parkings only if there are parkings
              Expanded(
                child: ListView(
                  children:
                      parkings.map((e) => ParkingCard(parking: e)).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
