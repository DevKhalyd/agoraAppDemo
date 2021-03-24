import 'package:demo_videocalling/features/dashboard/data/api/cloud_firestore_dashboard.dart';
import 'package:demo_videocalling/features/login/domain/models/user_model.dart';

class CFDashBoardUseCase {
  final useCase = CloudFirestoreDashboard();

  Stream<List<UserLocalModel>> getContacts() {
    try {
      return useCase.getContacts();
    } catch (e) {
      return null;
    }
  }
}
