class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final String iconType;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.iconType = 'laptop',
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? iconType,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      iconType: iconType ?? this.iconType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'iconType': iconType,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      isCompleted: (map['isCompleted'] as int? ?? 0) == 1,
      iconType: map['iconType'] as String? ?? 'laptop',
    );
  }
}

