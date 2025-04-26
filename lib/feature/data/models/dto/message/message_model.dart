import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/domain/entities/message_entity.dart';
import 'package:nasmobile/feature/domain/mapper/mapper.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel implements Transfer<MessageEntity> {
  final String? currentMail;
  final String? receiverMail;
  final DateTime? timestamp;
  final String? content;

  MessageModel({
    this.currentMail,
    this.receiverMail,
    this.timestamp,
    this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  MessageEntity transfer() => MessageEntity(
        currentMail:
            currentMail != null && currentMail!.isNotEmpty ? currentMail : null,
        receiverMail: receiverMail != null && receiverMail!.isNotEmpty
            ? receiverMail
            : null,
        timestamp: timestamp,
        content: content != null && content!.isNotEmpty ? content : null,
      );
}
