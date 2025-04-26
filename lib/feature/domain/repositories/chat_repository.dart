import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nasmobile/core/errors/failure.dart';
import 'package:nasmobile/feature/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      saveMessages({
    required MessageEntity message,
    required String chatRoomId,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String chatRoomId,
  });
}
