import 'package:flutter/material.dart';

class RejectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rejections = [
    {
      "garageId": "Garaje A",
      "date": "2022-09-01",
      "type": "Cliente",
      "reason": "No acepta tarifa",
      "location": "Calle 123"
    },
    {
      "garageId": "Garaje B",
      "date": "2022-09-05",
      "type": "Ofertante",
      "reason": "Espacio no disponible",
      "location": "Avenida Principal"
    },
    {
      "garageId": "Garaje C",
      "date": "2022-09-10",
      "type": "Cliente",
      "reason": "Retraso en acceso",
      "location": "Calle 45"
    },
    {
      "garageId": "Garaje A",
      "date": "2022-09-12",
      "type": "Ofertante",
      "reason": "Cancelación última hora",
      "location": "Calle 123"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rechazos"),
      ),
      body: ListView.builder(
        itemCount: rejections.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> rejection = rejections[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(
                  rejection['type'] == "Cliente" ? Icons.person : Icons.store,
                  color: Colors.red),
              title: Text("${rejection['garageId']} - ${rejection['reason']}"),
              subtitle: Text(
                  "${rejection['type']} - ${rejection['date']} - ${rejection['location']}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Función para gestionar rechazos o añadir nuevos
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
