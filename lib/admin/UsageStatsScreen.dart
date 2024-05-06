import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class UsageStatsScreen extends StatefulWidget {
  @override
  _UsageStatsScreenState createState() => _UsageStatsScreenState();
}

class _UsageStatsScreenState extends State<UsageStatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _timeSpanIndex = 0; // 0: daily, 1: weekly, 2: monthly
  int? _expandedTileIndex;
  final List<Map<String, dynamic>> topClients = [
    {"name": "1. Denzel", "transactions": 100, "stars": 5},
    {"name": "2. Kevin Molina", "transactions": 80, "stars": 4},
  ];

  final List<Map<String, dynamic>> worstClients = [
    {"name": "1. Alexander", "stars": 3},
    {"name": "2. Andrés", "stars": 2},
  ];

  List<int> dailyParkingUsage = List.generate(
      5, (_) => Random().nextInt(10) + 1); // Limitado a 10 usos por parqueo

  // Simulación de precios por parqueo
  List<double> hourlyRates =
      List.generate(15, (_) => 5 + Random().nextDouble() * 10); // Entre 5 y 15
  List<double> dailyRates = List.generate(
      15, (_) => 20 + Random().nextDouble() * 30); // Entre 20 y 50

  final List<Map<String, dynamic>> clientRejections = [
    {"user": "Usuario 1", "reason": "Precio alto", "date": "2022-01-05"},
    {
      "user": "Usuario 2",
      "reason": "No aceptó condiciones",
      "date": "2022-01-15"
    },
  ];

  final List<Map<String, dynamic>> providerRejections = [
    {
      "user": "Proveedor 1",
      "reason": "Espacio no disponible",
      "date": "2022-01-10"
    },
    {
      "user": "Proveedor 2",
      "reason": "Cancelación por clima",
      "date": "2022-01-20"
    },
  ];

  // Datos simulados para rankings

  final List<Map<String, dynamic>> topProviders = List.generate(
      20,
      (index) => {
            "name": "Proveedor ${index + 1}",
            "transactions": 100 - index,
          });

  final List<Map<String, dynamic>> worstProviders = List.generate(
      20,
      (index) => {
            "name": "Proveedor ${index + 1}",
            "transactions": index,
          });

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Proper disposal of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Administrativo"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.update), text: "Uso Actual"),
            Tab(icon: Icon(Icons.attach_money), text: "Precios"),
            Tab(icon: Icon(Icons.cancel), text: "Rechazos"),
            Tab(icon: Icon(Icons.list), text: "Rankings"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCurrentUsage(),
          _buildPricing(),
          _buildRejections(),
          _buildRankings(),
        ],
      ),
    );
  }

  Widget _buildCurrentUsage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text("Parqueos Usados Hoy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text("25", // Se cambia a 25 parqueos usados hoy
                style: TextStyle(fontSize: 22, color: Colors.green)),
            leading: Icon(Icons.directions_car, size: 40),
          ),
          ListTile(
            title: Text("Peticiones Totales",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text("30", // Se cambia a 30 peticiones totales
                style: TextStyle(fontSize: 22, color: Colors.green)),
            leading: Icon(Icons.query_stats, size: 40),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: dailyParkingUsage.reduce(max).toDouble() *
                      1.2, // to allow space above bars
                  barGroups: dailyParkingUsage
                      .asMap()
                      .entries
                      .map((e) => BarChartGroupData(
                            x: e.key,
                            barRods: [
                              BarChartRodData(
                                  toY: e.value.toDouble(), color: Colors.blue),
                            ],
                          ))
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) =>
                            Text('P${value.toInt() + 1}'),
                      ),
                    ),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageSection(String title, String data) {
    return ListTile(
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      subtitle: Text(data, style: TextStyle(fontSize: 22, color: Colors.green)),
      leading: Icon(Icons.directions_car, size: 40),
    );
  }

  Widget _buildConcurrentHoursChart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChart(BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barGroups: _buildBarGroups(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: true, getTitlesWidget: _buildTitles),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
        )),
      ),
    );
  }

  Widget _buildPricing() {
    double averageHourlyRate = 12.50; // Promedio por hora de 12.50 bs
    double averageDailyRate = 35.00; // Precio por día de 35 bs

    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text("Precio Promedio por Hora",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text("Bs ${averageHourlyRate.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 22, color: Colors.blue)),
            leading: Icon(Icons.access_time, size: 40),
          ),
          ListTile(
            title: Text("Precio Promedio por Día",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text("Bs ${averageDailyRate.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 22, color: Colors.blue)),
            leading: Icon(Icons.calendar_today, size: 40),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateSpots(int timeSpanIndex, int rentalTypeIndex) {
    // Aquí asumimos que ambos índices afectan la generación de los puntos
    int baseMultiplier =
        rentalTypeIndex == 0 ? 5 : 10; // Factor base por tipo de alquiler
    int periodMultiplier = timeSpanIndex == 0
        ? 30
        : timeSpanIndex == 1
            ? 40
            : 60; // Factor por período de tiempo
    int count = timeSpanIndex == 0
        ? 7
        : timeSpanIndex == 1
            ? 4
            : 6; // Cantidad de datos basada en el período

    return List.generate(
        count,
        (index) => FlSpot(index.toDouble(),
            (baseMultiplier * index) % periodMultiplier.toDouble()));
  }

  Widget _buildTitles(double value, TitleMeta meta) {
    final titles = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']; // Example months
    return Text(titles[value.toInt()],
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(
        4,
        (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                    toY: (index + 1) * 20.0, color: Colors.deepPurple)
              ],
            ));
  }

  Widget _buildRejections() {
    return ListView(
      padding: EdgeInsets.all(8),
      children: [
        ExpansionTile(
          leading:
              Icon(Icons.store_mall_directory, size: 40, color: Colors.orange),
          title: Text("Rechazos por Ofertantes: ${providerRejections.length}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          children: providerRejections
              .map((rejection) => Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(Icons.store, color: Colors.orange),
                      title: Text(rejection['user'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle:
                          Text("${rejection['reason']} - ${rejection['date']}"),
                      tileColor: Colors.orange.shade50,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRankings() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text("Rankings de Ofertantes y Clientes",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
        _buildExpansionTile(
            0, "Top 20 Ofertantes", Colors.green, topProviders, true),
        _buildExpansionTile(
            1, "20 Peores Ofertantes", Colors.red, worstProviders, false),
        ExpansionTile(
          initiallyExpanded: _expandedTileIndex == 2,
          onExpansionChanged: (bool expanded) {
            setState(() {
              if (expanded) {
                _expandedTileIndex = 2;
              } else {
                _expandedTileIndex = null;
              }
            });
          },
          leading: Icon(Icons.trending_up, color: Colors.blue),
          title: Text("Top 20 Clientes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue)),
          children: [
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.yellow),
                title: Text("1. Denzel"),
                subtitle: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
              ),
            ),
            ...topClients
                .map((item) => Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle:
                            Text("Transacciones: ${item['transactions']}"),
                      ),
                    ))
                .toList(),
          ],
        ),
        ExpansionTile(
          initiallyExpanded: _expandedTileIndex == 3,
          onExpansionChanged: (bool expanded) {
            setState(() {
              if (expanded) {
                _expandedTileIndex = 3;
              } else {
                _expandedTileIndex = null;
              }
            });
          },
          leading: Icon(Icons.trending_down, color: Colors.orange),
          title: Text("20 Peores Clientes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orange)),
          children: [
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.star_border, color: Colors.orange),
                title: Text("1. Alexander"),
                subtitle: Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.orange),
                    Icon(Icons.star_border, color: Colors.orange),
                    Icon(Icons.star_border, color: Colors.orange),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.star_border, color: Colors.orange),
                title: Text("2. Andrés"),
                subtitle: Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.orange),
                    Icon(Icons.star_border, color: Colors.orange),
                  ],
                ),
              ),
            ),
            ...worstClients
                .map((item) => Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(item['name']),
                      ),
                    ))
                .toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildExpansionTile(int index, String title, Color color,
      List<Map<String, dynamic>> data, bool isPositive) {
    return ExpansionTile(
      initiallyExpanded: _expandedTileIndex == index,
      onExpansionChanged: (bool expanded) {
        setState(() {
          if (expanded) {
            _expandedTileIndex = index;
          } else {
            _expandedTileIndex = null;
          }
        });
      },
      leading: Icon(isPositive ? Icons.trending_up : Icons.trending_down,
          color: color),
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: color)),
      children: data
          .map((item) => Card(
                color: Colors
                    .white, // Usamos un fondo blanco para todas las tarjetas
                child: ListTile(
                  leading: Icon(
                      isPositive ? Icons.check_circle_outline : Icons.cancel,
                      color: color),
                  title: Text(item['name'], style: TextStyle(color: color)),
                  subtitle: Text("Transacciones: ${item['transactions']}",
                      style: TextStyle(color: color)),
                ),
              ))
          .toList(),
    );
  }
}
