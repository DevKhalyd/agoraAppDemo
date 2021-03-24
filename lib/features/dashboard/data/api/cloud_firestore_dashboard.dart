import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_videocalling/core/utils/shared_prefs.dart';
import 'package:demo_videocalling/features/login/domain/models/user_model.dart';

import '../../../../core/blueprints/cloud_firestore_impl.dart';
import '../../../../core/mixins/collections_firestore.dart';

class CloudFirestoreDashboard extends CloudFirestoreImpl
    with CollectionsFirestoreImpl {
  final prefs = MyShPrefs();

  Stream<List<UserLocalModel>> getContacts() async* {
    Stream<QuerySnapshot> qs;

    try {
      qs = users.snapshots();
    } catch (e) {
      rethrow;
    }

    final contacts = <UserLocalModel>[];

    await for (QuerySnapshot q in qs) {
      contacts.clear();

      q.docs.forEach((doc) {
        final c = UserLocalModel.fromJson(doc.data());
        final idSelf = prefs.id;
        if (c.id != idSelf) contacts.add(c);
      });

      yield contacts;
    }
  }
}
