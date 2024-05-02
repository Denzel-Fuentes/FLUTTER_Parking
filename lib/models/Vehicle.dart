class Vehicle {
   String id;
  final String brand;
  final String model;
  final String registrationPlate;
  final double high;
  final double wide;
  final double long;
  final String userId;

  Vehicle({
    this.id = " ",
    required this.brand,
    required this.model,
    required this.registrationPlate,
    required this.high,
    required this.wide,
    required this.long,
    required this.userId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      brand: json['brand'],
      model: json['model'],
      registrationPlate: json['registrationplate'],
      high: json['high'].toDouble(),
      wide: json['wide'].toDouble(),
      long: json['long'].toDouble(),
      userId: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'brand': brand,
      'model': model,
      'registrationplate': registrationPlate,
      'high': high,
      'wide': wide,
      'long': long,
      'user': userId,
    };
  }
}
