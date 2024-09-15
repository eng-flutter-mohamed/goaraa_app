import 'package:get/get.dart';
class Service {
  final String name;
  final double price;
  RxBool isChecked;

  Service({required this.name, required this.price, bool isChecked = false})
      : isChecked = isChecked.obs;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'isChecked': isChecked.value,
    };
  }

  static Service fromMap(Map<String, dynamic> map) {
    return Service(
      name: map['name'],
      price: map['price'],
      isChecked: map['isChecked'] ?? false,
    );
  }

  // Override toString for better readability
  @override
  String toString() {
    return 'Service(name: $name, price: $price, isChecked: ${isChecked.value})';
  }
}
