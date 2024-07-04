class BookModel {
  String? title;
  String? author;
  DateTime? createdAt;
  String? id;

  BookModel({
    this.title,
    this.author,
    this.createdAt,
    this.id,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        title: json["title"],
        author: json["author"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
