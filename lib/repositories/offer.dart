import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Offer.dart';
import 'package:parking_app/services/repository.dart';

class OfferRepository extends Repository<Offer> {
  OfferRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('offers'),
            fromJson: (json) => Offer.fromJson(json),
            toJson: (item) => item.toJson());

  Future<List<Offer>> getAllByFieldAndState(String field, String param, {String state = "LIBRE"}) async {
    List<Offer> offers = await super.getAllByField(field, param);
    return offers.where((offer) => offer.state == state).toList();
  }
}
