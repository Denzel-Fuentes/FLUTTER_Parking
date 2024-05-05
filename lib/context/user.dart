import 'package:parking_app/models/User.dart';

class UserManager {
  static User? _currentUser;

  static void setCurrentUser(User user) {
    _currentUser = user;
  }
  static User? get getCurrentUser => _currentUser;
}
