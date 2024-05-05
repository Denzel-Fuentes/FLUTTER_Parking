class User {
   String? id;
  final String fullName;
  final String? password;
  final String phone;
  final String email;
  final bool? isAdmin;

  User({
    this.id,
    required this.fullName,
    this.password,
    required this.phone,
    required this.email,
    this.isAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullname'],
      password: json['password'],
      phone: json['phone'],
      email: json['email'],
      isAdmin: json['is_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
      'password': password,
      'phone': phone,
      'email': email,
      'is_admin': isAdmin ?? false,
    };
  }
}
