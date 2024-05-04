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

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json["_id"],
      userId: json['user'],
      name: json['name'],
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'name': name,
      'location': location.toJson(),
    };
  }
}