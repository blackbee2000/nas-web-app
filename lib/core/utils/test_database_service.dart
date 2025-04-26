import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasmobile/feature/domain/entities/user_register_entity.dart';

class TestDatabaseService {
  final _fire = FirebaseFirestore.instance;

  Future<void> saveUser(UserRegisterEntity userData) async {
    try {
      await _fire
          .collection("users")
          .doc(userData.email)
          .set(userData.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserStream(
          String currentUserId) =>
      _fire
          .collection("users")
          .where("email", isNotEqualTo: currentUserId)
          .snapshots();
}
