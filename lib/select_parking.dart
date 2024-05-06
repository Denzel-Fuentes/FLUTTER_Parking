import 'package:flutter/material.dart';
import 'package:parking_app/Add_garage.dart'; // Asegúrate de que esta importación es correcta para tu RegisterGarageScreen
import 'package:parking_app/Cards/ParkingCard.dart';
import 'package:parking_app/context/Garage.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/Parking.dart';
import 'package:parking_app/repositories/parking.dart';
import 'Publish_offer.dart'; // Asegúrate de que esta importación es correcta para tu ParkingRentalScreen

class SelectParkingScreen extends StatefulWidget {
  @override
  _SelectParkingScreenState createState() => _SelectParkingScreenState();
}

class _SelectParkingScreenState extends State<SelectParkingScreen> {
  List<Parking> parkings = []; // Lista inicial vacía
  Parking? selectedParking; // Almacena el estacionamiento seleccionado

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
        title: const Text('Select Parking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              const Column(
                children: [
                  Text(
                    'No registered garages available',
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
              child: const Text('Add Garage'),
            ),
            if (parkings.isNotEmpty)
              Expanded(
                child: ListView(
                  children: parkings
                      .map((parking) => RadioListTile<Parking>(
                            title: ParkingCard(parking: parking),
                            value: parking,
                            groupValue: selectedParking,
                            onChanged: (Parking? value) {
                              setState(() {
                                selectedParking = value;
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedParking != null
                  ? () {
                      ParkingManager.setCurrentParking(selectedParking!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParkingRentalScreen(),
                        ),
                      );
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
