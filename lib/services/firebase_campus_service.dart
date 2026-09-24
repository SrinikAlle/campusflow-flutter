import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseCampusService {
  FirebaseCampusService._();

  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static Future<UserCredential> signInAnonymously() {
    return auth.signInAnonymously();
  }

  static Future<void> saveProfile(
    String userId,
    Map<String, dynamic> data,
  ) {
    return firestore
        .collection('users')
        .doc(userId)
        .set(data, SetOptions(merge: true));
  }
}
