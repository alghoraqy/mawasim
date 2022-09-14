import 'package:task/models/register_model.dart';

class ActivateAccountModel {
  final String message;
  final bool status;
  final ActivateAccountData activateAccountData;

  ActivateAccountModel({
    required this.message,
    required this.status,
    required this.activateAccountData,
  });

  factory ActivateAccountModel.fromJson(Map<String, dynamic> json) {
    return ActivateAccountModel(
      message: json['message'],
      status: json['status'],
      activateAccountData: ActivateAccountData.fromJson(json['data']),
    );
  }
}

class ActivateAccountData {
  final UserData userData;
  final String token;

  ActivateAccountData({
    required this.userData,
    required this.token,
  });
  factory ActivateAccountData.fromJson(Map<String, dynamic> json) {
    return ActivateAccountData(
        userData: UserData.fromJson(json['user']), token: json['token']);
  }
}
