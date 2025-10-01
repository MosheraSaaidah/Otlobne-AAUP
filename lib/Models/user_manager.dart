import 'user.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  final List<User> _registeredUsers = [];

  bool registerUser(User user) {
    if (_registeredUsers.any((u) => u.email == user.email)) {
      return false; // Email already exists
    }
    _registeredUsers.add(user);
    return true;
  }

  User? login(String username, String password) {
    try {
      return _registeredUsers.firstWhere(
        (u) => u.userName == username && u.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  List<User> get allUsers => _registeredUsers;
}
