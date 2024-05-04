import 'package:parking_app/context/user.dart';
import 'package:parking_app/models/User.dart';
import 'package:parking_app/repositories/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserService {
  UserRepository repository;
  UserService({required this.repository});

  Future<void> register(User user) async {
    await fb.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, password: user.password!);
    await repository.create(user);
    UserManager.setCurrentUser(user);
  }

  Future<void> login({required String email, required String password}) async {
    if (fb.FirebaseAuth.instance.currentUser != null) {
      fb.User current = fb.FirebaseAuth.instance.currentUser!;
      UserManager.setCurrentUser(await repository.getByEmail(current.email!));
    } else {
      await fb.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserManager.setCurrentUser(await repository.getByEmail(email));
    }
  }

  static logout() {
    return fb.FirebaseAuth.instance.signOut();
  }
}
