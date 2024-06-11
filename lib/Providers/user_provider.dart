import 'package:flutter/widgets.dart';
import 'package:uniapp/models/user.dart';
import 'package:uniapp/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User? user = await _authMethods.getCurrentUserData();
    _user = user;
    notifyListeners();
  }
}
