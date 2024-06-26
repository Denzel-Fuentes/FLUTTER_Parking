class Offer {
  final String? id;
  final String? parkingId;
  final int price;
  final String description;
  final String title;
  final double high;
  final double wide;
  final double long;
  String? state;
  final String type;

  Offer({
    this.id,
    this.parkingId,
    required this.price,
    required this.description,
    required this.title,
    required this.high,
    required this.wide,
    required this.long,
    this.state = "DESOCUPADO",
    required this.type,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      parkingId: json['parking'],
      price: json['price'].toInt(),
      description: json['description'],
      title: json['tittle'],
      high: json['high'].toDouble(),
      wide: json['wide'].toDouble(),
      long: json['long'].toDouble(),
      state: json['state'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (parkingId != null) 'parking': parkingId,
      'price': price,
      'description': description,
      'tittle': title,
      'high': high,
      'wide': wide,
      'long': long,
      'state': state,
      'type': type,
    };
  }
}
