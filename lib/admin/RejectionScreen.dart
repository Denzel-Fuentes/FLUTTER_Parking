import 'package:flutter/material.dart';

class RejectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rejections = [
    {"date": "2022-09-01", "type": "Cliente", "reason": "No acepta tarifa"},
    {"date": "2022-09-05", "type": "Ofertante", "reason": "Espacio no disponible"},
    {"date": "2022-09-10", "type": "Cliente", "reason": "Retraso en acceso"},
    {"date": "2022-09-12", "type": "Ofertante", "reason": "Cancelación última hora"},
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
              leading: Icon(rejection['type'] == "Cliente" ? Icons.person : Icons.store, color: Colors.red),
              title: Text(rejection['reason']),
              subtitle: Text("${rejection['type']} - ${rejection['date']}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí se podría implementar una función para agregar nuevos rechazos o gestionar los existentes
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
