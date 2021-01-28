class ForumTanya {
  String id;
  String judul;
  String desc;
  DateTime date;
  List<dynamic> comment;
  List<dynamic> like;

  ForumTanya(
      {this.id, this.desc, this.comment, this.date, this.judul, this.like});

  factory ForumTanya.fromJSON(String id, Map<String, dynamic> json) {
    return ForumTanya(
      id: id,
      judul: json['judul'],
      desc: json['desc'],
      like: json['like'],
      comment: json['comment'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }
}
