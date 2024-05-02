class Calification {
  final String? id;
  final String userId;
  final String parkingId;
  final bool isParkingAuthor;
  final DateTime date;
  final int calification;

  Calification({
    this.id,
    required this.userId,
    required this.parkingId,
    required this.isParkingAuthor,
    required this.date,
    required this.calification,
  });

  factory Calification.fromJson(Map<String, dynamic> json) {
    return Calification(
      id: json['_id'],
      userId: json['user'],
      parkingId: json['parking'],
      isParkingAuthor: json['is_parkingauthor'],
      date: DateTime.parse(json['date']),
      calification: json['calification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'parking': parkingId,
      'is_parkingauthor': isParkingAuthor,
      'date': date.toIso8601String(),
      'calification': calification,
    };
  }
}
