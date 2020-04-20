class LoginModel {
  final String valid;

  LoginModel({this.valid});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(valid: json['valid']);
  }

  Map<String, dynamic> toJson() => {'valid': valid};
}