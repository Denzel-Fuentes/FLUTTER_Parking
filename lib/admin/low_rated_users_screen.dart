import 'package:flutter/material.dart';

class LowRatedUsersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  LowRatedUsersScreen({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios con Bajas Calificaciones'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['name']),
            subtitle: Text('Puntuación: ${users[index]['rating']}'),
          );
        },
      ),
    );
  }
}

// Datos ficticios para la pantalla de usuarios con bajas calificaciones
List<Map<String, dynamic>> lowRatedUsers = List.generate(20, (index) => {
  "name": "Usuario Bajo ${index + 1}",
  "rating": 2.0 - index * 0.05, // Puntuaciones bajas
});
