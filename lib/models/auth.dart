import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_kombat/models/database.dart';
import 'package:mobile_kombat/models/player.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Database _database = Database();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  signUp(String email, String password, String nickname) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _database.addUser(credential, nickname);
      Player().username = nickname;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var username = await _database.getUserName(credential.user!.uid);
      Player().username = username;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void initializeUser() async {
    var username = await _database.getUserName(currentUser!.uid);
    Player().username = username;
  }
}
