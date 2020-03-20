import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<void> signInWithCredentials(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(User user) async {
    await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    var userId = (await _auth.currentUser()).uid;
    user.id = userId;
    return _db.collection('users').document(userId).setData(user.toMap());
  }

  Future<void> signOut() async {
    return Future.wait([
      _auth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final authUser = await _auth.currentUser();
    return authUser != null;
  }

  Future<User> getUser() async {
    var authUser = await _auth.currentUser();
    var doc = await _db.collection('users').document(authUser.uid).get();
    return User.fromDocument(doc)..email = authUser.email;
  }
}