/// Class used to pass information
///
/// **[level]** specifies the the type of information.
///
/// **[message]** is a [String] that contains the message to be passed.
///
/// **[data]** stores whatever is important in a form of a [Map<String, dynamic>]
class MessageType {
  final MessageLevel level;
  final String message;
  final Map<String, dynamic>? data;

  const MessageType({required this.level, required this.message, this.data});

  @override
  String toString() {
    return '$level: $message. \n \t $data';
  }
}

/// Possibles level message
enum MessageLevel{
  info, warning, error, success,
}