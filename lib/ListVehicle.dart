import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking_app/Cards/VehicleCard.dart';
import 'package:parking_app/models/Vehicle.dart';

class ListVehicleScreen extends StatefulWidget {
  const ListVehicleScreen({super.key});

  @override
  State<ListVehicleScreen> createState() => _ListVehicleScreenState();
}

class _ListVehicleScreenState extends State<ListVehicleScreen> {
 final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _marca = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehículos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('Añadir'),
                ),
              ),
              VehicleCard(vehicle: Vehicle(brand: "Susuki", model: "Samurai", registrationPlate: "PdDS001", high: 22.5, wide: 2.4, long: 50.3, userId: "1"))
            ],
          ),
        ),
      ); 
  }
}  