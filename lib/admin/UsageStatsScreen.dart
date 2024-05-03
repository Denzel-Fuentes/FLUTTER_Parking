import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class UsageStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estadísticas de Uso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20,
            barTouchData: BarTouchData(
              enabled: true,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    switch (value.toInt()) {
                      case 0: return Text('Jan');
                      case 1: return Text('Feb');
                      case 2: return Text('Mar');
                      case 3: return Text('Apr');
                      case 4: return Text('May');
                      case 5: return Text('Jun');
                      case 6: return Text('Jul');
                      case 7: return Text('Aug');
                      case 8: return Text('Sep');
                      case 9: return Text('Oct');
                      case 10: return Text('Nov');
                      case 11: return Text('Dec');
                      default: return Text('');
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: List.generate(12, (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: (index + 1) * 1.5,
                  color: Colors.lightBlue
                )
              ]
            )),
          ),
        ),
      ),
    );
  }
}
