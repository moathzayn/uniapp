class ChatContact {
  final String email;
  final String uid;
  final String photoUrl;
  final String text;
  final String username;
  final DateTime timeSent;
  const ChatContact(
      {required this.email,
      required this.uid,
      required this.text,
      required this.photoUrl,
      required this.username,
      required this.timeSent});
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "uid": uid,
      "email": email,
      "photoUrl": photoUrl,
      "text": text,
      "timeSent": timeSent,
    };
  }

  factory ChatContact.formMap(Map<String, dynamic> map) {
    return ChatContact(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      timeSent: map['timeSent'],
      text: map['text'],
    );
  }
}
