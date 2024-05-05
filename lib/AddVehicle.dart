import 'package:flutter/material.dart';
import 'package:parking_app/context/user.dart'; // Asegúrate de que el manejo del usuario está correctamente implementado
import 'package:parking_app/models/Vehicle.dart';
import 'package:parking_app/repositories/vehicle.dart';

class AddVehicle extends StatelessWidget {
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController anchoController = TextEditingController();
  final TextEditingController largoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Vehículo'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            TextField(
              controller: alturaController,
              decoration: InputDecoration(labelText: 'Altura'),
            ),
            TextField(
              controller: anchoController,
              decoration: InputDecoration(labelText: 'Ancho'),
            ),
            TextField(
              controller: largoController,
              decoration: InputDecoration(labelText: 'Largo'),
            ),
            ElevatedButton(
              onPressed: () async {
                Vehicle newVehicle = Vehicle(
                  brand: marcaController.text,
                  model: modeloController.text,
                  registrationPlate: placaController.text,
                  high: double.parse(alturaController.text),
                  wide: double.parse(anchoController.text),
                  long: double.parse(largoController.text),
                  userId: UserManager.getCurrentUser?.id ?? "defaultUserId",
                );
                try {
                  var vehicleRepo = VehicleRepository();
                  String vehicleId = await vehicleRepo.create(newVehicle);
                  newVehicle.id = vehicleId;
                  Navigator.pop(context, newVehicle);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al guardar el vehículo: $e')));
                }
              },
              child: Text('Añadir vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}
