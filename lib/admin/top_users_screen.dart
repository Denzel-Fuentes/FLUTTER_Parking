import 'package:flutter/material.dart';

class TopUsersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  TopUsersScreen({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Usuarios'),
        backgroundColor: Colors
            .blue, // Asegúrate de que el color esté en línea con tu esquema de diseño
      ),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(users[index]['name'],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Puntuación: ${users[index]['rating']}'),
              trailing: Icon(Icons.star, color: Colors.amber),
            ),
          );
        },
      ),
    );
  }
}

// Datos ficticios para la pantalla de top usuarios
List<Map<String, dynamic>> topUsers = List.generate(
    20,
    (index) => {
          "name": "Usuario ${index + 1}",
          "rating":
              5.0 - index * 0.1, // Simula una disminución en la puntuación
        });
