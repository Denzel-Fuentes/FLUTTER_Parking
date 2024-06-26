import 'package:flutter/material.dart';

class OffersProposeTAB extends StatefulWidget {
  const OffersProposeTAB({super.key});
  @override
  State<OffersProposeTAB> createState() => _OffersProposeTABState();
}

class _OffersProposeTABState extends State<OffersProposeTAB> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,  // Ajuste aquí
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(text: "Reservas", icon: Icon(Icons.directions_car)),
            Tab(text: "Ofertas", icon: Icon(Icons.directions_transit)),
          ]),
        ),
      ),
    );
  }
}
