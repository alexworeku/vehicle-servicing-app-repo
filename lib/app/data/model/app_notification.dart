class AppNotification {
  String id;
  String content;
  String sentDate;
  String senderType;
  String senderId;
  String recieverId;
  AppNotification(
      {this.id,
      this.content,
      this.senderType,
      this.sentDate,
      this.recieverId,
      this.senderId});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': id,
      'Content': content,
      'SenderType': senderType,
      'SentDate': sentDate,
      'Reciever': recieverId,
      'SenderId': senderId
    };
  }

  AppNotification.fromMap(String nid, Map<String, dynamic> data)
      : this(
          id: nid,
          content: data['Content'],
          senderType: data['SenderType'],
          sentDate: data['SentDate'],
          recieverId: data['Reciever'],
          senderId: data['SenderId'],
        );
}
