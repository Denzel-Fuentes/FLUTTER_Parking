import 'package:flutter/material.dart';
import 'package:parking_app/Add_offer.dart';
import 'package:parking_app/list_offers.dart';

class ParkingDetails extends StatefulWidget {
  const ParkingDetails({super.key});

  @override
  State<ParkingDetails> createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Parqueo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Expanded(
          child: ListView(
        children: [
          _buildListTile(
              title: "Añadir oferta",
              icon: Icons.add,
              textColor: Colors.black,
              onTap: () {
                NextScren(ListOffersScreen());
              }),
          Divider(color: Colors.blueGrey),
          _buildListTile(
              title: "Ver publicaciones",
              icon: Icons.newspaper,
              textColor: Colors.black,
              onTap: () {}),
          Divider(color: Colors.blueGrey),
          _buildListTile(
              title: "Editar datos del Garage",
              icon: Icons.garage,
              textColor: Colors.black,
              onTap: () {}),
          Divider(color: Colors.blueGrey),
        ],
      )),
    );
  }

  void NextScren(Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => screen ));

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
