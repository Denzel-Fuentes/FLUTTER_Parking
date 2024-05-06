import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking_app/Add_offer.dart';
import 'package:parking_app/models/Offer.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final bool showDeleteIcon;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const OfferCard(
      {Key? key,
      required this.offer,
      this.showDeleteIcon = false,
      required this.onDelete,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ?? () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AddOfferScreen(offer: offer,)));
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(offer.description),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Price: \$${offer.price}"),
                        Text("Type: ${offer.type}"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('high : ${offer.high} '),
                        Text('wide : ${offer.wide} '),
                        Text('long : ${offer.long} '),
                      ],
                    )
                  ],
                ),
              ),
              if (showDeleteIcon)
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
