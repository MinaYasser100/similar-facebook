class SocialChatModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;
  String? chatImage;

  SocialChatModel({
    this.senderId,
    this.reciverId,
    this.dateTime,
    this.text,
    this.chatImage,
  });

  SocialChatModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    chatImage = json['chatImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'dateTime': dateTime,
      'text': text,
      'chatImage': chatImage,
    };
  }
}
