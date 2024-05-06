import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class UsageStatsScreen extends StatefulWidget {
  @override
  _UsageStatsScreenState createState() => _UsageStatsScreenState();
}

class _UsageStatsScreenState extends State<UsageStatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _timeSpanIndex = 0; // 0: daily, 1: weekly, 2: monthly
  int? _expandedTileIndex;

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
  final List<Map<String, dynamic>> topClients = List.generate(
      20,
      (index) => {
            "name": "Cliente ${index + 1}",
            "transactions": 100 - index,
          });

  final List<Map<String, dynamic>> worstClients = List.generate(
      20,
      (index) => {
            "name": "Cliente ${index + 1}",
            "transactions": index,
          });

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
          _buildUsageSection("Parqueos Usados Hoy", "250"),
          _buildUsageSection("Peticiones Totales", "320"),
          _buildConcurrentHoursChart(),
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
    List<String> timeSpans = ["Diario", "Semanal", "Mensual"];
    List<String> rentalTypes = ["Por Hora", "Por Día"];
    int _rentalTypeIndex = 0; // 0 para por hora, 1 para por día

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Evolución de Precios",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          ToggleButtons(
            borderColor: Colors.blueAccent,
            fillColor: Colors.lightBlue.shade50,
            borderWidth: 2,
            selectedBorderColor: Colors.blue,
            selectedColor: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
            children: rentalTypes
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(e),
                    ))
                .toList(),
            isSelected: List.generate(
                rentalTypes.length, (index) => index == _rentalTypeIndex),
            onPressed: (int index) {
              setState(() {
                _rentalTypeIndex = index;
              });
            },
          ),
          SizedBox(height: 20),
          ToggleButtons(
            borderColor: Colors.green,
            fillColor: Colors.green.shade50,
            borderWidth: 2,
            selectedBorderColor: Colors.green,
            selectedColor: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10),
            children: timeSpans
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(e),
                    ))
                .toList(),
            isSelected: List.generate(
                timeSpans.length, (index) => index == _timeSpanIndex),
            onPressed: (int index) {
              setState(() {
                _timeSpanIndex = index;
              });
            },
          ),
          AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final titles = _timeSpanIndex == 0
                            ? ['01', '02', '03', '04', '05', '06', '07']
                            : _timeSpanIndex == 1
                                ? ['Week 1', 'Week 2', 'Week 3', 'Week 4']
                                : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                        return Text(titles[value.toInt()],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold));
                      },
                    ),
                  ),
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: true)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateSpots(_timeSpanIndex, _rentalTypeIndex),
                    isCurved: true,
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: true),
                    color: _rentalTypeIndex == 0
                        ? Colors.redAccent
                        : Colors.blueAccent,
                  ),
                ],
              ),
            ),
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
          leading: Icon(Icons.person_off, size: 40, color: Colors.red),
          title: Text("Rechazos por Clientes: ${clientRejections.length}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          children: clientRejections
              .map((rejection) => Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.red),
                      title: Text(rejection['user'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle:
                          Text("${rejection['reason']} - ${rejection['date']}"),
                      tileColor: Colors.red.shade50,
                    ),
                  ))
              .toList(),
        ),
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
        _buildExpansionTile(
            2, "Top 20 Clientes", Colors.blue, topClients, true),
        _buildExpansionTile(
            3, "20 Peores Clientes", Colors.orange, worstClients, false),
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
