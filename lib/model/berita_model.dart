class Beritamodel {
  final String id;
  final List<dynamic> comment;
  final DateTime date;
  final String deskripsi;
  final String image;
  final String judul;
  final String kategori;

  Beritamodel({this.id, this.comment, this.date, this.deskripsi, this.image, this.judul, this.kategori});
  
  factory Beritamodel.fromjson(Map<String,dynamic> json,String id){
    return Beritamodel(
      id: id ,
      judul: json['judul'],
      kategori: json['kategori'],
      deskripsi: json['deskripsi'],
      image: json['image'],
      comment: json['comment'] ,
      date: DateTime.fromMillisecondsSinceEpoch(json['date'])

    );

  }
}