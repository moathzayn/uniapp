enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  gif('gif');

  const MessageEnum(this.type);
  final String type;
}

extension Convert on String {
  MessageEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'text':
        return MessageEnum.text;
      case 'image':
        return MessageEnum.image;
      case 'gif':
        return MessageEnum.gif;
      default:
        return MessageEnum.text;
    }
  }
}
