import 'package:flutter/material.dart';
import 'package:parking_app/context/Garage.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/repositories/offer.dart';
import 'package:parking_app/services/repository.dart';

class AddOfferScreen extends StatefulWidget {
  final bool isPreviewMode;
  final Offer? offer;
  const AddOfferScreen({super.key, this.isPreviewMode = false, this.offer});
  @override
  _AddOfferScreenState createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  int price = 20;
  String? pricingType = 'daily'; // Tipo de precio, 'daily' o 'hourly'
  TextEditingController descriptionController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.offer != null) {
      price = widget.offer!.price;
      pricingType = widget.offer!.type;
      descriptionController.text = widget.offer!.description;
      heightController.text = widget.offer!.high.toString();
      widthController.text = widget.offer!.wide.toString();
      lengthController.text = widget.offer!.long.toString();
    }
  }

  void saveOffer() async {
    Offer newOffer = Offer(
        parkingId:
            widget.isPreviewMode ? "0" : ParkingManager.getCurrentParking!.id!,
        price: price,
        description: descriptionController.text,
        title: "",
        high: double.parse(heightController.text),
        wide: double.parse(widthController.text),
        long: double.parse(lengthController.text),
        state: "LIBRE",
        type: pricingType!);

    if (widget.isPreviewMode) {
      Navigator.pop(context, newOffer);
    } else {
      await OfferRepository().create(newOffer);
    }
  }

  void deleteOffer() async {
    await OfferRepository().delete(widget.offer!.id!);
  }

  void updateOffer() async {
    await OfferRepository().update(
        widget.offer!.id!,
        Offer(
            price: price,
            description: descriptionController.text,
            title: "",
            high: double.parse(heightController.text),
            wide: double.parse(widthController.text),
            long: double.parse(lengthController.text),
            state: "LIBRE",
            type: pricingType!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añade tu oferta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Ajusta tu precio',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (price > 1) price--;
                      });
                    },
                  ),
                  Text('${price} bs', style: TextStyle(fontSize: 24)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        price++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Añade una descripción a tu oferta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Text('Dimensiones del espacio',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Alto (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: widthController,
                decoration: InputDecoration(
                  labelText: 'Ancho (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: lengthController,
                decoration: InputDecoration(
                  labelText: 'Largo (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text('Elige tu horario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                title: const Text('Por día'),
                leading: Radio<String>(
                  value: 'daily',
                  groupValue: pricingType,
                  onChanged: (String? value) {
                    setState(() {
                      pricingType = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Por hora'),
                leading: Radio<String>(
                  value: 'hourly',
                  groupValue: pricingType,
                  onChanged: (String? value) {
                    setState(() {
                      pricingType = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              if (widget.offer != null)
                ElevatedButton(
                  onPressed: deleteOffer,
                  child: Text('Eliminar',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  // Set the width of the button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: updateOffer,
                child: Text('Actualizar',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                // Set the width of the button
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              if (widget.offer == null)
                Center(
                  child: ElevatedButton(
                    onPressed: saveOffer,
                    child: Text('Añadir', style: TextStyle(fontSize: 16)),
                    // Set the width of the button
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
