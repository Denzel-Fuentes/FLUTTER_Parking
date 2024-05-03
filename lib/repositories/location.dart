import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Location.dart';
import 'package:parking_app/services/repository.dart';

class LocationRepository extends Repository<Location> {
  LocationRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('locations'),
            fromJson: (json) => Location.fromJson(json),
            toJson: (item) => item.toJson());
}
