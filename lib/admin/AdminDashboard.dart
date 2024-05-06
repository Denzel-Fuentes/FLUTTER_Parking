import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UsageStatsScreen.dart';
import 'PricingScreen.dart';
import 'RejectionScreen.dart';
import 'TopUsersScreen.dart';
import 'WorstUsersScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking_app/login_def.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Widget _selectedScreen = UsageStatsScreen();
  String fullName = "Cargando...";
  String email = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user.email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          setState(() {
            fullName = userData['fullname'] ?? "Nombre no disponible";
            email = userData['email'] ?? "Email no disponible";
          });
        } else {
          print("No se encontró el documento con el correo: ${user.email}");
        }
      } catch (e) {
        print("Error al cargar los datos del usuario: $e");
      }
    } else {
      print("No hay usuario autenticado o falta el correo electrónico.");
    }
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
              accountName: Text(fullName),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(fullName.isNotEmpty ? fullName[0] : 'A',
                    style: TextStyle(fontSize: 40.0)),
              ),
            ),
            _buildDrawerItem(
                Icons.query_stats, 'Estadísticas de Uso', UsageStatsScreen()),
            _buildDrawerItem(
                Icons.attach_money, 'Precios Convenidos', PricingScreen()),
            _buildDrawerItem(Icons.thumb_down, 'Rechazos', RejectionScreen()),
            _buildDrawerItem(Icons.star, 'Top 20 Usuarios', TopUsersScreen()),
            _buildDrawerItem(Icons.warning,
                'Usuarios con Peores Calificaciones', WorstUsersScreen()),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar Sesión'),
              onTap: () {
                // Implementar lógica de logout
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginDef()));
              },
            ),
          ],
        ),
      ),
      body: _selectedScreen,
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _selectScreen(screen),
    );
  }

  void _selectScreen(Widget screen) {
    setState(() {
      _selectedScreen = screen;
    });
  }
}
