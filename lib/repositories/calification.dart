import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Calification.dart';
import 'package:parking_app/services/repository.dart';

class CalificationRepository extends Repository<Calification> {
  CalificationRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('califications'),
            fromJson: (json) => Calification.fromJson(json),
            toJson: (item) => item.toJson());
}
