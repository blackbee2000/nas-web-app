import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/feature/data/datasources/chat_datasource.dart';
import 'package:nasmobile/feature/domain/entities/message_entity.dart';
import 'package:nasmobile/feature/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String chatRoomId,
  }) {
    return ChatDatasource.to.getMessages(chatRoomId: chatRoomId);
  }

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      saveMessages({
    required MessageEntity message,
    required String chatRoomId,
  }) async {
    try {
      return right(
        await ChatDatasource.to.saveMessage(
          message: message,
          chatRoomId: chatRoomId,
        ),
      );
    } catch (e) {
      return left(SystemFailure(e.toString()));
    }
  }
}
