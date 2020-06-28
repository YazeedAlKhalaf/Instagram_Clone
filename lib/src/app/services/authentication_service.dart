// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';
// import 'package:instagram_clone/src/app/models/user_data.dart';
// import 'package:provider/provider.dart';

// @lazySingleton
// class AuthService {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = Firestore.instance;

//   Future<FirebaseUser> getCurrentUser() async {
//     final FirebaseUser user = await _auth.currentUser();
//     return user;
//   }

//   Future<String> getCurrentUserId() async {
//     FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//     String currentUserId = currentUser.uid;
//     return currentUserId;
//   }

//   void signUpUser(
//       BuildContext context, String name, String email, String password) async {
//     try {
//       AuthResult authResult = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       FirebaseUser signedInUser = authResult.user;
//       if (signedInUser != null) {
//         _firestore.collection('/users').document(signedInUser.uid).setData({
//           'name': name,
//           'email': email,
//           'profileImageUrl': '',
//         });
//         Provider.of<UserData>(context).currentUserId = signedInUser.uid;
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void logout() {
//     _auth.signOut();
//   }

//   void login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print(e);
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_clone/src/app/generated/locator/locator.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/app/services/firestore_service.dart';

@lazySingleton
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;
  User get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String fullName,
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = User(
        id: authResult.user.uid,
        name: fullName,
        email: authResult.user.email,
        profileImageUrl: '',
      );

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);

    return user != null;
  }

  _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUserWithId(user.uid);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
