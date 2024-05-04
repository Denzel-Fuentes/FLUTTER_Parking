import 'package:parking_app/models/User.dart';
import 'package:parking_app/repositories/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserService {
  UserRepository repository;
  UserService({required this.repository});

  Future<void> register(User user) async {
    await fb.FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password!);
    await repository.create(user);

  }

  Future<User> login({required String email,required String password}) async {
    await fb.FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return repository.getByEmail(email);
  }


}
