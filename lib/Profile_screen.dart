import 'package:flutter/material.dart';
import 'package:parking_app/ListParking.dart';
import 'package:parking_app/ListVehicle.dart';
import 'package:parking_app/login_def.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    Color lightGray = Colors.grey.shade300;
 
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cuenta',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                Divider(color: lightGray)
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                _buildSubtitle('Información', textColor),
                _buildListTile(
                  title: 'Mis Vehículos',
                  icon: Icons.directions_car,
                  textColor: textColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListVehicleScreen()),
                    );
                  },
                ),
                Divider(color: lightGray),
                _buildListTile(
                  title: 'Mis Garajes',
                  icon: Icons.local_parking,
                  textColor: textColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListParkingScreen()),
                    );
                  },
                ),
                
                Divider(color: lightGray),
                _buildListTile(
                  title: 'Cerrar sesión',
                  icon: Icons.exit_to_app,
                  textColor: Colors.red,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginDef()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }

  Widget _buildUserTile({
    required String username,
    required Color textColor,
    required Color lightGray,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        child: Icon(Icons.person, size: 20, color: Colors.blue),
        backgroundColor: lightGray,
      ),
      title: Text(
        username,
        style: TextStyle(
          fontSize: 20,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}
