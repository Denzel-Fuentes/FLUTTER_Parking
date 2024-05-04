import 'package:flutter/material.dart';
import 'package:parking_app/context/user.dart';
import 'package:parking_app/list_garages.dart';
import 'package:parking_app/list_offers.dart';
import 'package:parking_app/login_def.dart';
import 'package:parking_app/services/user.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    Color lightGray = Colors.grey.shade300;

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 16), // Top padding for the icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightGray,
                  ),
                  child: Icon(Icons.person,
                      size: 80.0, color: textColor), // User icon
                ),
                SizedBox(height: 8), // Space between the icon and the text
                Text(
                  UserManager.getCurrentUser!.fullName,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                SizedBox(height: 16), // Space before the subtitle
              ],
            ),
          ),
          _buildSubtitle('Información', textColor),
          Expanded(
            child: ListView(
              children: [
                _buildListTile(
                  title: 'Registrar vehículo',
                  icon: Icons.directions_car,
                  textColor: textColor,
                  onTap: () {},
                ),
                Divider(color: lightGray),
                _buildListTile(
                  title: 'Añadir oferta',
                  icon: Icons.add_circle_outline,
                  textColor: textColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListOffersScreen()), // Asegúrate de que AddOfferScreen esté definido y disponible
                    );
                  },
                ),
                Divider(color: lightGray),
                _buildListTile(
                  title: 'Publicar oferta',
                  icon: Icons.public,
                  textColor: textColor,
                  onTap: () {},
                ),
                Divider(color: lightGray),
                _buildListTile(
                  title: 'Mis garajes',
                  icon: Icons.local_parking,
                  textColor: textColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListGaragesScreen()), // Asegúrate de que AddOfferScreen esté definido y disponible
                    );
                  },
                ),
                Divider(color: lightGray),
                _buildListTile(
                  title: 'Puntuación',
                  icon: Icons.star,
                  textColor: textColor,
                  onTap: () {},
                ),
                Divider(color: lightGray),
                _buildListTileNoArrow(
                  title: 'Cerrar sesión',
                  icon: Icons.exit_to_app,
                  textColor: Colors.red,
                  onTap: () async {
                    await UserService.logout();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginDef()));
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
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
      ),
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
      trailing: Icon(Icons.chevron_right, color: textColor), // Add right arrow
      onTap: onTap,
    );
  }

  Widget _buildListTileNoArrow({
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
