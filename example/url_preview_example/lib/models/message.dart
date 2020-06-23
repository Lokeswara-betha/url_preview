import 'dart:convert';

class Message {
  String text;
  int type;
  Message({
    this.text,
    this.type,
  });

  Message copyWith({
    String text,
    int type,
  }) {
    return Message(
      text: text ?? this.text,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'type': type,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      text: map['text'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  static Message fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Message(text: $text, type: $type)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Message && o.text == text && o.type == type;
  }

  @override
  int get hashCode => text.hashCode ^ type.hashCode;
}
