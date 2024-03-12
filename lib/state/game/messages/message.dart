class MessageLink {
  final String id;
  final String text;
  final String url;

  const MessageLink({required this.id, required this.text, required this.url});
}

class Message {
  final String title;
  final String message;
  final List<MessageLink> links;
  final Message? next;

  const Message({required this.title, required this.message, this.links = const [], this.next});
}
