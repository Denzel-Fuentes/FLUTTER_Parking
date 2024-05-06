import 'package:parking_app/models/Parking.dart';

class ParkingManager {
  static Parking? _currentParking;

  static void setCurrentParking(Parking parking) {
    _currentParking = parking;
  }

  static Parking? get getCurrentParking => _currentParking;
}
