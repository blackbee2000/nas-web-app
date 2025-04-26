import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasmobile/feature/domain/entities/message_entity.dart';

class ChatDatasource {
  static ChatDatasource get to => ChatDatasource();
  final _fire = FirebaseFirestore.instance;

  /// Save message
  Future<DocumentReference<Map<String, dynamic>>> saveMessage({
    required MessageEntity message,
    required String chatRoomId,
  }) async {
    final data = await _fire
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(message.toJson());
    return data;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String chatRoomId,
  }) {
    return _fire
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
