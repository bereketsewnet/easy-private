import 'package:hive/hive.dart';

part 'HivePrivateChatModel.g.dart';

@HiveType(typeId: 0)
class HivePrivateChatModel {
  @HiveField(0)
  final String? messageId;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final String sender;

  @HiveField(3)
  final String receiver;

  @HiveField(4)
  final String timeStamp;

  @HiveField(5)
  final bool isSeen;

  @HiveField(6)
  final String messageType;

  @HiveField(7)
  final String? replayMessage;

  HivePrivateChatModel({
    this.messageId,
    required this.message,
    required this.sender,
    required this.receiver,
    required this.timeStamp,
    required this.isSeen,
    this.messageType = 'Text',
    this.replayMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timeStamp': timeStamp,
      'isSeen': isSeen,
      'messageType': messageType,
      'replayMessage': replayMessage,
    };
  }

  factory HivePrivateChatModel.fromJson(Map<String, dynamic> json) {
    return HivePrivateChatModel(
      messageId: json['messageId'],
      message: json['message'],
      sender: json['sender'],
      receiver: json['receiver'],
      timeStamp: json['timeStamp'],
      isSeen: json['isSeen'],
      messageType: json['messageType'] ?? 'Text',
      replayMessage: json['replayMessage'],
    );
  }
}
