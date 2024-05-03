import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Schedule.dart';
import 'package:parking_app/services/repository.dart';

class ScheduleRepository extends Repository<Schedule> {
  ScheduleRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('schedules'),
            fromJson: (json) => Schedule.fromJson(json),
            toJson: (item) => item.toJson());
}
