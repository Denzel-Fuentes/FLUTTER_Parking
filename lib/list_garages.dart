import 'package:flutter/material.dart';
import 'package:parking_app/Add_garage.dart';
class ListGaragesScreen extends StatelessWidget {
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
            Text(
              'Aún no tienes garages registrados',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ), // Espacio vertical entre el mensaje y el botón
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterGarageScreen()), // Asegúrate de que AddOfferScreen esté definido y disponible
                );
              },
              child: Text('Añadir Garage'),
            ),
          ],
        ),
      ),
    );
  }
}
