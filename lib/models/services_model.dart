class ServicesModel {
  List<ServiceData> data = [];
  ServicesModel.fromJson(Map<String, dynamic> json) {
    List.from(json['data']).map((e) {
      data.add(ServiceData.fromJson(e));
    }).toList();
  }
}

class ServiceData {
  final int id;
  final String title;
  final String description;
  final String image;
  final String category;
  final dynamic price;

  ServiceData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.price,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        category: json['category'],
        price: json['price']);
  }
}
