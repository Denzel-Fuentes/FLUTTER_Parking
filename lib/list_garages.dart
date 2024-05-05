import 'package:flutter/material.dart';
import 'package:parking_app/Add_garage.dart';
import 'package:parking_app/Cards/ParkingCard.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/Parking.dart';
import 'package:parking_app/repositories/parking.dart'; // Asegúrate de que el archivo Add_garage.dart contiene un widget RegisterGarageScreen

class ListGaragesScreen extends StatefulWidget {
  @override
  _ListGaragesScreenState createState() => _ListGaragesScreenState();
}

class _ListGaragesScreenState extends State<ListGaragesScreen> {
  late List<Parking> parkings;
  @override
  void initState(){
    super.initState();
    loadParkings();
  }
   Future<void> loadParkings() async {
    
    List<Parking> loadedParkings = await ParkingRepository().getAllByField('user', UserManager.getCurrentUser!.id!);
    setState(() { parkings = loadedParkings; });
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
          if (parkings.isEmpty) // Mostrar mensaje solo si no hay parqueos
            Column(
              children: [
                Text(
                  'Aún no tienes garages registrados',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
              ],
            ),
          if (parkings.isNotEmpty) // Mostrar botón de añadir solo si hay parqueos
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
          if (parkings.isNotEmpty) // Mostrar lista de parqueos solo si hay parqueos
            Expanded(
              child: ListView(
                children: parkings.map((e) => ParkingCard(parking: e)).toList(),
              ),
            ),
        ],
      ),
    ),
  );
}

}
