import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/User.dart';
import 'package:parking_app/services/repository.dart';

class UserRepository extends Repository<User> {
  UserRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('users'),
            fromJson: (json) => User.fromJson(json),
            toJson: (item) => item.toJson());
}
