import 'package:flutter/material.dart';
import 'stats_screen.dart';
import 'top_users_screen.dart';
import 'low_rated_users_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para cada pantalla
    final barGroups = createBarGroups();
    final topUsers = createTopUsers();
    final lowRatedUsers = createLowRatedUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Administrativo'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (int index) {},
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                selectedIcon: Icon(Icons.bar_chart),
                label: Text('Statistics'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.message),
                selectedIcon: Icon(Icons.message),
                label: Text('Messages'),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      InfoCard('Earnings', '\$628', Icons.monetization_on,
                          Colors.blue),
                      InfoCard('Shares', '2434', Icons.share, Colors.green),
                      InfoCard('Likes', '1259', Icons.thumb_up, Colors.red),
                      InfoCard('Rating', '8.5', Icons.star, Colors.amber),
                      // Placeholder para gráficos y más información
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.blueGrey.withOpacity(0.3),
                        child: Center(child: Text('Gráfico de Barras')),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.orange.withOpacity(0.3),
                        child: Center(child: Text('Gráfico Circular')),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget InfoCard(String title, String value, IconData icon, Color color) {
  return Card(
    child: Container(
      width: 180,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.grey)),
          Text(value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

List<BarChartGroupData> createBarGroups() {
  return [
    BarChartGroupData(
      x: 0,
      barRods: [BarChartRodData(toY: 20, color: Colors.blue)],
      showingTooltipIndicators: [0],
    ),
    // Añade más datos según necesites
  ];
}

List<Map<String, dynamic>> createTopUsers() {
  return List.generate(
      20,
      (index) => {
            "name": "Top User $index",
            "rating": 5.0 - index * 0.1,
          });
}

List<Map<String, dynamic>> createLowRatedUsers() {
  return List.generate(
      20,
      (index) => {
            "name": "Low Rated User $index",
            "rating": 2.0 - index * 0.1,
          });
}
