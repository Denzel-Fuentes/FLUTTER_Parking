import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Parking.dart';
import 'package:parking_app/services/repository.dart';

class ParkingRepository extends Repository<Parking> {
  ParkingRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('parkings'),
            fromJson: (json) => Parking.fromJson(json),
            toJson: (item) => item.toJson());
}
