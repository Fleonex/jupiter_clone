import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('Users');

  signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = authResult.user;

      return user;
    } catch (e) {

      print("I got this error $e\n");
      return null;
    }
  }

   createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = authResult.user;

      _usersCollectionReference.doc(user!.uid).set({
        'email': email,
        'totalExpenses': 0,
        'noOfTransactions': 0,
      });

      return user;
    } catch (e) {
      print("I got this error $e\n");
      return null;
    }
  }
  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      // Check if user already exists
      final DocumentSnapshot userDoc = await _usersCollectionReference.doc(user!.uid).get();

      if (!userDoc.exists) {
        _usersCollectionReference.doc(user.uid).set({
          'email': user.email,
          'totalExpenses': 0,
          'noOfTransactions': 0,
        });
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      _auth.signOut();
      return "success";
    } catch (e) {
      return "error";
    }
  }
}

