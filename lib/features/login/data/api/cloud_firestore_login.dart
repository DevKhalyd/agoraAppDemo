import '../../../../core/blueprints/cloud_firestore_impl.dart';
import '../../../../core/mixins/collections_firestore.dart';
import '../../domain/models/user_model.dart';

class CloudFirestoreLogin extends CloudFirestoreImpl
    with CollectionsFirestoreImpl {
      
  Future<void> addUserLocal(UserLocalModel user) async {
    try {
      await users.doc(user.id).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}

