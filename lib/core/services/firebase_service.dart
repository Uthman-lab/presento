part of '../core.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static Stream<firebase_auth.User?> get authStateChanges =>
      auth.authStateChanges();

  static firebase_auth.User? get currentUser => auth.currentUser;

  static Future<void> signOut() async {
    await auth.signOut();
  }
}
