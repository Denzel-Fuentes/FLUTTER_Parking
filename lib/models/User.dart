
class User {
  final String? id;
  final String fullName;
  final String? password;
  final String phone;
  final String email;

  User({
    this.id,
    required this.fullName,
    this.password,
    required this.phone,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullname'],
      password: json['password'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullName,
      'password': password,
      'phone': phone,
      'email': email,
    };
  }
}
