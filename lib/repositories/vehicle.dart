import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Vehicle.dart';
import 'package:parking_app/services/repository.dart';

class VehicleRepository extends Repository<Vehicle> {
  VehicleRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('vehicles'),
            fromJson: (json) => Vehicle.fromJson(json),
            toJson: (item) => item.toJson());
}
