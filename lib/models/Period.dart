class Period {
  final String open;
  final String close;
  final String state;
  final String? priceId;

  Period({
    required this.open,
    required this.close,
    required this.state,
    this.priceId,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      open: json['open'],
      close: json['close'],
      state: json['state'],
      priceId: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'open': open,
      'close': close,
      'state': state,
      'price': priceId,
    };
  }
}