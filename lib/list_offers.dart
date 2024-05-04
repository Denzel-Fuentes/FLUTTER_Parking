import 'package:flutter/material.dart';
import 'package:parking_app/add_offer.dart';

class ListOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ofertas'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aún no tienes ofertas registradas',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ), // Espacio vertical entre el mensaje y el botón
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para añadir una oferta
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddOfferScreen()), // Asegúrate de que AddOfferScreen esté definido y disponible
                );
              },
              child: Text('Añadir Oferta'),
            ),
          ],
        ),
      ),
    );
  }
}
