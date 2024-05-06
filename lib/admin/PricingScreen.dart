import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> pricingData = [
    {"type": "Horas", "price": 5.0, "details": "Precio por hora"},
    {"type": "Días", "price": 20.0, "details": "Precio por día"}
  ];

  final List<Map<String, dynamic>> rejections = [
    {"type": "Cliente", "count": 12},
    {"type": "Ofertante", "count": 7}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Precios Convenidos y Rechazos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Promedios de Precios por Tipo de Alquiler", style: Theme.of(context).textTheme.headline6),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('Tipo de Alquiler')),
                DataColumn(label: Text('Precio')),
                DataColumn(label: Text('Detalles')),
              ],
              rows: pricingData.map((data) => DataRow(
                cells: [
                  DataCell(Text(data["type"])),
                  DataCell(Text("\$${data["price"]}")),
                  DataCell(Text(data["details"])),
                ],
              )).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Rechazos por Cliente y Ofertante", style: Theme.of(context).textTheme.headline6),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rejections.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(rejections[index]["type"]),
                  trailing: Text("${rejections[index]["count"]} rechazos"),
                  leading: Icon(rejections[index]["type"] == "Cliente" ? Icons.person_outline : Icons.store),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}