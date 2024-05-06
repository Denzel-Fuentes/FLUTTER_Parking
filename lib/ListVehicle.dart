import 'package:flutter/material.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/Vehicle.dart';
import 'package:parking_app/repositories/vehicle.dart';
import 'package:parking_app/AddVehicle.dart';
import 'package:parking_app/Cards/VehicleCard.dart';

class ListVehicleScreen extends StatefulWidget {
  @override
  _ListVehicleScreenState createState() => _ListVehicleScreenState();
}

class _ListVehicleScreenState extends State<ListVehicleScreen> {
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  void loadVehicles() async {
    var vehicleRepo = VehicleRepository();
    try {
      vehicles = await vehicleRepo.getAllByField("user",UserManager.getCurrentUser!.id);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al cargar vehículos: $e')));
    }
  }

  void _navigateAndAddVehicle(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddVehicle()),
    );

    if (result is Vehicle) {
      setState(() {
        vehicles.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehículos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _navigateAndAddVehicle(context),
              child: Text('Añadir Vehículo'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  return VehicleCard(vehicle: vehicles[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
