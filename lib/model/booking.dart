import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goaraa_app_eg1/model/service.dart';

class Booking {
  String id;
  List<Service> services;
  String status;
  DateTime createdAt;

  Booking({
    required this.id,
    required this.services,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'services': services.map((service) => service.toMap()).toList(),
      'status': status,
      'created_at': createdAt,
    };
  }

  static Booking fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      services: List<Service>.from(
          map['services'].map((service) => Service.fromMap(service))),
      status: map['status'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }
}
