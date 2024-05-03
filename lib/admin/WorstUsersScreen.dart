import 'package:flutter/material.dart';

class WorstUsersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = List.generate(10, (index) => {
    "name": "Usuario ${10 - index}",
    "rating": 1.0 + index * 0.4, // Puntuaciones ascendentes desde 1.0
    "infractions": index, // Número de infracciones o problemas registrados
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios con Peores Calificaciones"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Implementación de una funcionalidad de filtrado
              // Por ejemplo, abrir un diálogo para filtrar por rango de calificación
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text(users[index]['name'][8]), // La letra inicial del nombre del usuario
              ),
              title: Text(users[index]['name']),
              subtitle: Text("Calificación: ${users[index]['rating'].toStringAsFixed(1)} - Infracciones: ${users[index]['infractions']}"),
              trailing: Icon(Icons.thumb_down, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
