import 'package:parking_app/models/Period.dart';

class Schedule {
  final String? id;
  final String dateId;
  final String day;
  final bool isPerHour;
  final List<Period> periods;
  final String state;
  final String priceId;

  Schedule({
    this.id,
    required this.dateId,
    required this.day,
    required this.isPerHour,
    required this.periods,
    required this.state,
    required this.priceId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['_id'],
      dateId: json['date'],
      day: json['day'],
      isPerHour: json['is_perHour'],
      periods: (json['periods'] as List).map((period) {
        return Period.fromJson(period);
      }).toList(),
      state: json['state'],
      priceId: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': dateId,
      'day': day,
      'is_perHour': isPerHour,
      'periods': periods.map((period) => period.toJson()).toList(),
      'state': state,
      'price': priceId,
    };
  }
}
