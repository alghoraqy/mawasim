class ActivateModel {
  final String message;
  final bool status;
  ActivateModel({
    required this.message,
    required this.status,
  });

  factory ActivateModel.fromJson(Map<String, dynamic> json) {
    return ActivateModel(
      message: json['message'],
      status: json['status'],
    );
  }
}
