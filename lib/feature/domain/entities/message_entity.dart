class MessageEntity {
  final String? currentMail;
  final String? receiverMail;
  final DateTime? timestamp;
  final String? content;

  MessageEntity({
    this.currentMail,
    this.receiverMail,
    this.timestamp,
    this.content,
  });

  MessageEntity copyWith({
    String? currentMail,
    String? receiverMail,
    DateTime? timestamp,
    String? content,
  }) =>
      MessageEntity(
        currentMail: currentMail ?? this.currentMail,
        receiverMail: receiverMail ?? this.receiverMail,
        timestamp: timestamp ?? this.timestamp,
        content: content ?? this.content,
      );

  Map<String, dynamic> toJson() => {
        "currentMail": currentMail,
        "receiverMail": receiverMail,
        "timestamp": timestamp?.toIso8601String(),
        "content": content,
      };
}
