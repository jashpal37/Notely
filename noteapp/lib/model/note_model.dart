final String tableNotes = 'notes'; // table name

class NoteFields {
  static final List<String> values = [id, title, description, time];
  static final String id = '_id'; // SQL convention
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time:
            createdTime.toIso8601String(), // to convert into String obj
      };

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );
}
