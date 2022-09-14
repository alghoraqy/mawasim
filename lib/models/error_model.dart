class ErrorModel {
  final String message;
  final String status;

  ErrorModel({
    required this.message,
    required this.status,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'],
      status: json['status'],
    );
  }
}
