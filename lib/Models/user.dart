
class User {
  late String userName;
  late String email;
  late String password;

  User({required this.userName, required this.email, required this.password});

  bool validateLogin(String inputName , String inputPass) {
    return userName==inputName && password ==inputPass; 
  }

   bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

    bool isValidPassword() => password.length >= 6;

  bool isValidUsername() => userName.isNotEmpty && userName.length >= 3;
}

