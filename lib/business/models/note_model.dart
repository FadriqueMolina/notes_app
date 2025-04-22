class Note {
  final String id;
  final String title;
  String content;
  DateTime lastEdited;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.lastEdited,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    title: json["title"] ?? '',
    content: json["content"] ?? '',
    lastEdited: DateTime.parse(json['last_edited']),
  );

  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content};
  }
}
