import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/User.dart';
import 'package:parking_app/services/repository.dart';

class UserRepository extends Repository<User> {
  UserRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('users'),
            fromJson: (json) => User.fromJson(json),
            toJson: (item) => item.toJson());

  Future<User> getByEmail(String email) async{
     QuerySnapshot<Map<String,dynamic>> snapshots = await collection.where("email", isEqualTo: email).get();
     return User.fromJson({"_id":snapshots.docs[0].id,...snapshots.docs[0].data()});
  }
}
