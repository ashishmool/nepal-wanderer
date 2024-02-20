import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepal_wanderer/repo/user_repo.dart';

import '../models/auth_model.dart';

class UserViewModel extends ChangeNotifier {
  Future<void> save(UserModel data) async {
    await UserRepo().saveUsers(data);
  }

  List<QueryDocumentSnapshot<UserModel>> _data = [];
  List<QueryDocumentSnapshot<UserModel>> get data => _data;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getUsers() async {
    final res = await UserRepo().fetchUsers();
    _data = res;
    notifyListeners();
  }

  List<QueryDocumentSnapshot<UserModel>> _users = [];
  List<QueryDocumentSnapshot<UserModel>> get users => _users;

  UserModel _user = UserModel();
  UserModel get user => _user;

  Future<void> login(String email, String password) async {
    final res = await UserRepo().fetchUsers();

    _users = res;

    for (var a in _users) {
      if (a.data().email.toString() == email &&
          a.data().password.toString() == password) {
        _user = a.data();
      } else {
        _user = UserModel();
      }
    }

    notifyListeners();
  }
}
