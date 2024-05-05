import 'package:flutter/material.dart';
import 'package:parking_app/models/Parking.dart';

class ParkingCard extends StatelessWidget {
  final Parking parking;

  const ParkingCard({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.local_parking_outlined, size: 40),
            title: Text(parking.name, style: TextStyle(fontSize: 20)),
            
          ),
         /*  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0, 
              children: parking.additionalSigns
                  .map((sign) => Chip(
                        label: Text(sign),
                        avatar: Icon(Icons.warning, size: 20),
                      ))
                  .toList(),
            ), 
          ),*/
        ],
      ),
    );
  }
}
