import '../../data/api/cloud_firestore_login.dart';
import '../models/user_model.dart';


class CFLoginUseCase {

  final cfl = CloudFirestoreLogin();

  Future<bool> addUserLocal(UserLocalModel user) async {
    try {
      await cfl.addUserLocal(user);
    } catch (e) {
      return false;
    }
    return true;
  }
}


