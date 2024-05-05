import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Location.dart';

class Parking {
  final String? id;
  final String userId;
  final String name;
  final Location location;
  final List<String> additionalSigns;

  Parking({
    this.id,
    required this.userId,
    required this.name,
    required this.location,
    required this.additionalSigns
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json["_id"],
      userId: json['user'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      additionalSigns: List<String>.from(json["additional_signs"])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'name': name,
      'location': location.toJson(),
      'additional_signs': additionalSigns
    };
  }
}