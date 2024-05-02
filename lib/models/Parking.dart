import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Location.dart';

class Parking {
  final String? id;
  final String userId;
  final String name;
  final Location location;

  Parking({
    this.id,
    required this.userId,
    required this.name,
    required this.location,
  });

  factory Parking.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Parking(
      id: doc.id,
      userId: data['user'],
      name: data['name'],
      location: Location.fromJson(data['location']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': userId,
      'name': name,
      'location': location.toJson(),
    };
  }
}