import 'package:task/models/activate_acount_model.dart';

class LoginModel {
  final String message;
  final bool status;
  final ActivateAccountData activateAccountData;

  LoginModel({
    required this.message,
    required this.status,
    required this.activateAccountData,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      status: json['status'],
      activateAccountData: ActivateAccountData.fromJson(json['data']),
    );
  }
}
