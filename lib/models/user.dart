import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String password = "***";
  String phoneNumber;
  double balance = 0;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.balance,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      balance: doc['balance'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'balance': balance,
    };
  }

  @override
  String toString() {
    return '''User {
      id: $id,
      name: $name,
      email: $email,
      password: ***,
      phoneNumber: $phoneNumber,
      balance: $balance,
    }''';
  }
}
