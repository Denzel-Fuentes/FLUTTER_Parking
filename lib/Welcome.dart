import 'package:flutter/material.dart';
import 'package:parking_app/AddVehicle.dart';
import 'package:parking_app/RegistroScreen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¡Bienvenido!',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica para ir a la pantalla de vehículos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddVehicle()),
              );
            },
            child: Text('Vehículos'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica para ir a la pantalla de crear cuenta
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegistroScreen()),
              );
            },
            child: Text('Crear cuenta'),
          ),
        ],
      ),
    );
  }
}
