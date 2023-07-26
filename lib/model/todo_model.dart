class TodoModel {
  final String title;
  final String description;
  final bool isCompleted;
  final String date;
  final String userId;

  TodoModel(
      {required this.title,
      required this.description,
      required this.isCompleted,
      required this.date,
      required this.userId});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        date: json['date'],
        userId: json['userId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'date': date,
      'userId': userId
    };
  }
}
