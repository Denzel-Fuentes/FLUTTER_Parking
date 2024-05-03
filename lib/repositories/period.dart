import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Period.dart';
import 'package:parking_app/services/repository.dart';

class PeriodRepository extends Repository<Period> {
  PeriodRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('periods'),
            fromJson: (json) => Period.fromJson(json),
            toJson: (item) => item.toJson());
}
