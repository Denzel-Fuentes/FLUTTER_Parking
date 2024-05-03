import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TopUsersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = List.generate(10, (index) => {
    "name": "Usuario ${index + 1}",
    "rating": 5.0 - index * 0.5, // Puntuaciones descendientes
    "favoritePark": "Parqueo ${index % 3 + 1}", // Ejemplo de parqueo favorito
    "reviews": 10 + index * 2, // Número de reseñas hechas
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Usuarios"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aquí podrías añadir la funcionalidad de búsqueda
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(users[index]['name'][0]), // Primera letra del nombre
                    ),
                    title: Text(users[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(5, (starIndex) => Icon(
                            Icons.star,
                            size: 20,
                            color: starIndex < users[index]['rating'] ? Colors.amber : Colors.grey,
                          )),
                        ),
                        Text("Parqueo Favorito: ${users[index]['favoritePark']}"),
                        Text("Reseñas: ${users[index]['reviews']}"),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blueGrey[100],
            child: Text(
              "Información sobre las estadísticas de uso de parqueos por estos usuarios.",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
