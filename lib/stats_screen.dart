import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  final List<BarChartGroupData> barGroups;
  final bool animate;

  StatsScreen({Key? key, required this.barGroups, this.animate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas de Uso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            barGroups: barGroups,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.blueGrey,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${rod.toY.round()}',
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),
          swapAnimationDuration: animate ? Duration(milliseconds: 350) : Duration.zero,
        ),
      ),
    );
  }
}

// Función para crear datos de ejemplo para el gráfico
List<BarChartGroupData> createSampleData() {
  return [
    BarChartGroupData(
      x: 0,
      barRods: [BarChartRodData(toY: 5, color: Colors.lightBlue)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [BarChartRodData(toY: 25, color: Colors.blueAccent)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [BarChartRodData(toY: 100, color: Colors.deepPurpleAccent)],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [BarChartRodData(toY: 75, color: Colors.teal)],
      showingTooltipIndicators: [0],
    ),
  ];
}

// Usando StatsScreen con datos de ejemplo
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: StatsScreen(
        barGroups: createSampleData(),
        animate: true,
      ),
    ),
  ));
}
