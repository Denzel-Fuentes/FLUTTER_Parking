import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> pricingData = [
    {"type": "Horas", "price": 12.50, "details": "Precio por hora en Bs"},
    {"type": "Días", "price": 35.00, "details": "Precio por día en Bs"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Precios Convenidos"),
      ),
      body: SingleChildScrollView(
        child: Center(
          // Añadido para centrar el contenido en la pantalla
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Promedios de Precios por Tipo de Alquiler",
                    style: Theme.of(context).textTheme.headline6),
              ),
              Container(
                alignment: Alignment
                    .center, // Añadido para centrar el contenido en la columna
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Tipo de Alquiler')),
                    DataColumn(label: Text('Precio')),
                    DataColumn(label: Text('Detalles')),
                  ],
                  rows: pricingData
                      .map((data) => DataRow(
                            cells: [
                              DataCell(Text(data["type"])),
                              DataCell(Text(
                                  "Bs ${data["price"].toStringAsFixed(2)}")),
                              DataCell(Text(data["details"])),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
