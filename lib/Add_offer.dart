import 'package:flutter/material.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/repositories/offer.dart';


class AddOfferScreen extends StatefulWidget {
  final bool isPreviewMode;

  const AddOfferScreen({super.key,this.isPreviewMode = false});
  @override
  _AddOfferScreenState createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  int price = 20; // Precio inicial
  String? pricingType = 'daily'; // Tipo de precio, 'daily' o 'hourly'
  TextEditingController descriptionController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  void saveOffer() async{
    print('Precio: $price bs');
    print('Descripción: ${descriptionController.text}');
    print('Alto: ${heightController.text} cm');
    print('Ancho: ${widthController.text} cm');
    print('Largo: ${lengthController.text} cm');
    print('Precio es por: ${pricingType == "daily" ? "día" : "hora"}');

    if (widget.isPreviewMode){
      Offer newOffer = Offer(parkingId: "0", price: price, description: descriptionController.text, title: "", high: double.parse(heightController.text), wide: double.parse(widthController.text), long: double.parse(lengthController.text), state: "LIBRE", type: pricingType!);
      Navigator.pop(context,newOffer);
    }
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
