class noteModel {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? created;
  noteModel({this.id, this.userid, this.title, this.content, this.created});
  factory noteModel.fromMap(Map<String, dynamic> map) {
    return noteModel(
      id: map["id"],
      userid: map["userid"],
      title: map["title"],
      content: map["content"],
      created: DateTime.tryParse(map["created"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "title": title,
      "content": content,
      "created": created!.toIso8601String(),
    };
  }
}
