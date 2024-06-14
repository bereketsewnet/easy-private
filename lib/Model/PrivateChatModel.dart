class PrivateChatModel {
  final String message;
  final String sender;
  final String receiver;
  final String timeStamp;
  final bool isSeen;
  final String messageType;
  final String? replayMessage;


  PrivateChatModel({
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
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timeStamp': timeStamp,
      'isSeen': isSeen,
      'messageType': messageType,
      'replayMessage': replayMessage,
    };
  }

  factory PrivateChatModel.fromJson(Map<String, dynamic> json) {
    return PrivateChatModel(
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