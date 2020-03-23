import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String id;
  String model;
  String description;
  int capacity;
  double dailyFees;
  bool isAvailable;

  Vehicle({
    this.id,
    this.model,
    this.description,
    this.capacity,
    this.dailyFees,
    this.isAvailable,
  });

  factory Vehicle.fromDocument(DocumentSnapshot doc) {
    return Vehicle(
      id: doc['id'],
      model: doc['model'],
      description: doc['description'],
      capacity: doc['capacity'].ToInt(),
      dailyFees: doc['dailyFees'].toDouble(),
      isAvailable: doc['isAvailable'].toBool(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'description': description,
      'capacity': capacity,
      'dailyFees': dailyFees,
      'isAvailable': isAvailable,
    };
  }

  @override
  String toString() {
    return '''Vehicle {
       id: $id,
       model: $model,
       description: $description,
       capacity: $capacity,
       dailyFees: $dailyFees,
       isAvailable: $isAvailable
    }''';
  }
}
