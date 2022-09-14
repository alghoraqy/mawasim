class RegisterModel {
  final String message;
  final bool status;
  UserData? data;
  RegisterModel({required this.message, required this.status, this.data});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['message'],
      status: json['status'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final dynamic phone;
  final String email;
  final String image;
  final bool isNotify;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
    required this.isNotify,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      isNotify: json['is_notifiy'],
    );
  }
}
