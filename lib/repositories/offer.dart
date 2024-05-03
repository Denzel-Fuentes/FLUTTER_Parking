import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/services/repository.dart';

class OfferRepository extends Repository<Offer> {
  OfferRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('offers'),
            fromJson: (json) => Offer.fromJson(json),
            toJson: (item) => item.toJson());
}
