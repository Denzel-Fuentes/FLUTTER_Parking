import 'package:flutter/material.dart';
import 'package:parking_app/Welcome.dart'; // Asegúrate de importar el archivo de la pantalla de bienvenida

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
        title: Text('Vehículos'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Añadir vehículo',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
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
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para añadir vehículo
                // Aquí puedes agregar la lógica para almacenar el vehículo

                // Una vez que se haya añadido el vehículo, regresa a la pantalla de bienvenida
                Navigator.pop(context);
              },
              child: Text('Añadir vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}
