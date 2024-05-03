import 'package:flutter/material.dart';
import 'UsageStatsScreen.dart';
import 'PricingScreen.dart';
import 'RejectionScreen.dart';
import 'TopUsersScreen.dart';
import 'WorstUsersScreen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Widget _selectedScreen = UsageStatsScreen(); // Pantalla inicial por defecto

  void _selectScreen(Widget screen) {
    setState(() {
      _selectedScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Administrativo'),
        backgroundColor: const Color.fromARGB(255, 3, 79, 142),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("admin@company.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('AD', style: TextStyle(fontSize: 40.0)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.query_stats),
              title: Text('Estadísticas de Uso'),
              onTap: () => _selectScreen(UsageStatsScreen()),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Precios Convenidos'),
              onTap: () => _selectScreen(PricingScreen()),
            ),
            ListTile(
              leading: Icon(Icons.thumb_down),
              title: Text('Rechazos'),
              onTap: () => _selectScreen(RejectionScreen()),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Top 20 Usuarios'),
              onTap: () => _selectScreen(TopUsersScreen()),
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Usuarios con Peores Calificaciones'),
              onTap: () => _selectScreen(WorstUsersScreen()),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(), // Espacio vacío o para más contenido lateral
          ),
          Expanded(
            flex: 3,
            child:
                _selectedScreen, // Área principal que muestra la pantalla seleccionada
          ),
        ],
      ),
    );
  }
}
