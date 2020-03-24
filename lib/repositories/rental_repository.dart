import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp_wheels/models/rental.dart';

class RentalRepository {
  final Firestore _db = Firestore.instance;

  Future<void> saveRentalData(Rental rental) async {
    // TODO: Mark vehicle as not available
    var doc = _db.collection('rentals').document();
    rental.id = doc.documentID;
    return _db
        .collection('rentals')
        .document(doc.documentID)
        .setData(rental.toMap());
  }
}
