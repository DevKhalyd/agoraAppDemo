import 'package:cloud_firestore/cloud_firestore.dart';

import '../blueprints/cloud_firestore_impl.dart';

const USERS_COLLECTION = 'users';

mixin CollectionsFirestoreImpl on CloudFirestoreImpl {
  CollectionReference get users => firestore.collection(USERS_COLLECTION);
}
