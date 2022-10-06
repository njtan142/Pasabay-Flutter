import 'package:firebase_auth/firebase_auth.dart';
import 'package:taralets/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = credential.user;
      return user;
    } catch (_) {}
  }

  @override
  // TODO: implement user
  Stream<User?> get user => _firebaseAuth.userChanges();
}
