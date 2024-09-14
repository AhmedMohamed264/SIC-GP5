class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String username;
  String password;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
