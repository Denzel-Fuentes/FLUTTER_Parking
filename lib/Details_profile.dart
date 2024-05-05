import 'package:flutter/material.dart';
import 'package:parking_app/context/user.dart';
 
class DetailPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = UserManager.getCurrentUser;
 
    Color primaryColor = Colors.white;
    Color textColor = Colors.black;
    Color backgroundColor = Colors.grey.shade100;
    double dividerThickness = 2.0;
    Color dividerColor = Colors.grey.shade300;
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Perfil'),
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: user == null
          ? Center(child: Text('No se ha podido cargar el usuario.', style: TextStyle(color: textColor)))
          : SingleChildScrollView(
              child: Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 50.0,
                              child: Icon(Icons.person, size: 50.0, color: Colors.black),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      buildInfoCard("Nombre Completo", user.fullName, Icons.person, Colors.blue, textColor),
                      Divider(color: dividerColor, thickness: dividerThickness),
                      buildInfoCard("Correo Electrónico", user.email, Icons.email, Colors.red, textColor),
                      Divider(color: dividerColor, thickness: dividerThickness),
                      buildInfoCard("Número de Teléfono", user.phone, Icons.phone, Colors.green, textColor),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
 
  Widget buildInfoCard(String title, String value, IconData icon, Color iconColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                Text(value, style: TextStyle(color: textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 