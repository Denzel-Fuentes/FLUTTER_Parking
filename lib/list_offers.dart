import 'package:flutter/material.dart';
import 'package:parking_app/Cards/OfferCard.dart';
import 'package:parking_app/add_offer.dart';
import 'package:parking_app/context/Garage.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/repositories/offer.dart';

class ListOffersScreen extends StatefulWidget {
  const ListOffersScreen({super.key});

  @override
  State<ListOffersScreen> createState() => _ListOffersScreenState();
}

class _ListOffersScreenState extends State<ListOffersScreen> {
  List<Offer> offers = [];

  @override
  void initState() {
    super.initState();
    loadOffersByParking();
  }

  void loadOffersByParking() async {
    List<Offer> loadedOffers = await OfferRepository()
        .getAllByField("parking", ParkingManager.getCurrentParking!.id!);
    setState(() {
      offers = loadedOffers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ofertas'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (offers.isEmpty)
              Text(
                'Aún no tienes ofertas registradas',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddOfferScreen()),
                );
              },
              child: Text('Añadir Oferta'),
            ),
            if (offers.isNotEmpty)
              Expanded(
                child: ListView(
                  children: offers
                      .map((offer) => OfferCard(
                            offer: offer,
                            onDelete: () {},
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
