import 'package:cloud_firestore/cloud_firestore.dart';

/// Handle the main rules in this module
abstract class CloudFirestoreImpl {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
