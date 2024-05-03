import 'package:flutter/material.dart';
import 'package:parking_app/models/Vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: ListTile(
        leading: Icon(Icons.directions_car),
        title: Text('${vehicle.brand} ${vehicle.model}'),
        subtitle: Text('Registration Plate: ${vehicle.registrationPlate}\n'
            'Dimensions: ${vehicle.high}m H x ${vehicle.wide}m W x ${vehicle.long}m L'),
        onTap: () {
          // Add your onTap functionality here, if needed.
        },
      ),
    );
  }
}
