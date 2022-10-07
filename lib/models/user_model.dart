import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;
  Map<String, dynamic> userData = {};

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  
  }

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((authResult) async {
      firebaseUser = authResult.user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
      log('Acerto catch');
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
      log('erro catch');
    });
  }

  void signIn({
    required String email,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then(
      (user) async {
        firebaseUser = user.user;
        await _loadCurrentUser();
        onSuccess();
        isLoading = false;
        notifyListeners();
      },
    ).catchError(
      (e) {
        onFail();
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass(String email) {
    _auth
        .sendPasswordResetEmail(email: email)
        .onError((error, stackTrace) => (error));
  }

  bool isLoadingIn() {
    return firebaseUser != null;
  }
  
   bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.uid ?? '')
        .set(userData);
  }

  Future<void> _loadCurrentUser() async {
    firebaseUser ??= _auth.currentUser;
    if (firebaseUser != null) {
      if (userData['name'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser?.uid)
            .get();
        userData = docUser.data() as Map<String, dynamic>;
      }
    }
    notifyListeners();
  }
}
