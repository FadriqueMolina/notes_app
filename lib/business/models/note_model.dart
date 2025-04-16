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
}
