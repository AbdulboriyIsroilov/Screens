class LoginModel {
  final String login, password;

  LoginModel({
    required this.login,
    required this.password,
  });
  Map<String,dynamic> toJson(){
    return {
      "login":login,
      "password":password
    };
  }

}
