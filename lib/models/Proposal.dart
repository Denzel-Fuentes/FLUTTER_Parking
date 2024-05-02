class Proposal {
  final String? id;
  final String offerId;
  final String userId;
  final double price;
  final String description;
  final DateTime date;
  final String title;
  final String state;
  final String vehicleId;

  Proposal({
    this.id,
    required this.offerId,
    required this.userId,
    required this.price,
    required this.description,
    required this.date,
    required this.title,
    required this.state,
    required this.vehicleId,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      id: json['_id'],
      offerId: json['offer'],
      userId: json['user'],
      price: json['price'].toDouble(),
      description: json['description'],
      date: DateTime.parse(json['date']),
      title: json['tittle'],
      state: json['state'],
      vehicleId: json['vehicle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'offer': offerId,
      'user': userId,
      'price': price,
      'description': description,
      'date': date.toIso8601String(),
      'tittle': title,
      'state': state,
      'vehicle': vehicleId,
    };
  }
}
