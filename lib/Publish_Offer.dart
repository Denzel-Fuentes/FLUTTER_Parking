import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/Add_offer.dart';
import 'package:parking_app/context/Garage.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/repositories/offer.dart';

class ParkingRentalScreen extends StatefulWidget {
  ParkingRentalScreen({Key? key}) : super(key: key);
  @override
  _ParkingRentalScreenState createState() => _ParkingRentalScreenState();
}

class _ParkingRentalScreenState extends State<ParkingRentalScreen> {
  List<DateTime?> _selectedDates = [];
  CalendarDatePicker2Type _calendarType = CalendarDatePicker2Type.single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alquilar Estacionamiento'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Modo de selección:'),
              DropdownButton<CalendarDatePicker2Type>(
                value: _calendarType,
                onChanged: (value) {
                  setState(() {
                    _calendarType = value!;
                    _selectedDates = [];
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: CalendarDatePicker2Type.single,
                    child: Text('Un solo día'),
                  ),
                  DropdownMenuItem(
                    value: CalendarDatePicker2Type.range,
                    child: Text('Rango de días'),
                  ),
                  DropdownMenuItem(
                    value: CalendarDatePicker2Type.multi,
                    child: Text('Días específicos'),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: _calendarType,
              ),
              value: _selectedDates,
              onValueChanged: (dates) {
                setState(() {
                  _selectedDates = dates;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ListOffert())), // Utiliza el callback para cambiar al perfil
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}

class ListOffert extends StatefulWidget {
  const ListOffert({super.key});
  @override
  State<ListOffert> createState() => _ListOffert();
}

class _ListOffert extends State<ListOffert> {
  OfferRepository repository = OfferRepository();
  List<Offer> offers = [];
  List<Offer> selectedOffers = [];
  Map<int, bool> checkboxState = {};
  @override
  void initState() {
    super.initState();
    loadOffers();
  }

  Future<void> loadOffers() async {
    List<Offer> offersList = await repository.getAllByFieldAndState(
        "parking", ParkingManager.getCurrentParking!.id!,
        state: "DESOCUPADO");
    setState(() {
      offers = offersList;
    });
  }

  Future<void> publishSelectedOffers() async {
    if (selectedOffers.isNotEmpty) {
      await Future.wait(selectedOffers.map((element) async {
        element.state = "LIBRE";
        await repository.update(element.id!, element);
      }));
      selectedOffers.clear();
      checkboxState.clear();
      await loadOffers();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ninguna oferta seleccionada'),
            content: const Text(
                'Por favor, selecciona al menos una oferta antes de publicar.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el diálogo
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddOfferScreen(
                            onSuccess: () {
                              loadOffers();
                            },
                          )),
                );
              },
              child: const Text('Añadir Oferta'),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: offers.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.block, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "No hay ofertas libres por el momento.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        return itemOfferCheckbox(offers[index], index);
                      },
                    ),
            ),
            ElevatedButton(
              onPressed:
                  publishSelectedOffers, // Utiliza el callback para cambiar al perfil
              child: const Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemOfferCheckbox(Offer offer, int index) {
    bool isChecked = checkboxState[index] ?? false;
    return Card(
      child: CheckboxListTile(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            bool finalValue = value!;
            checkboxState[index] = finalValue;
            if (finalValue) {
              selectedOffers.add(offer);
            } else {
              selectedOffers.remove(offer);
            }
          });
        },
        title: Text(offer.description), // Descripción de la oferta
        subtitle: Text(
          '${offer.price} Bs', // Precio de la oferta
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        secondary: const Icon(Icons.airport_shuttle_sharp,
            size: 40), // Icono de un documento
      ),
    );
  }
}
