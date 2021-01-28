class CatShopModel {
  final String id;
  final String namaBarang;
  final String image;
  final String desc;
  final double rating;
  final int harga;
  final String linkShopee;

  CatShopModel(
      {this.desc,
      this.linkShopee,
      this.image,
      this.id,
      this.namaBarang,
      this.rating,
      this.harga});

  factory CatShopModel.fromJSON(String id, Map<String, dynamic> json) {
    return CatShopModel(
      id: id,
      namaBarang: json["namaBarang"],
      image: json["image"],
      desc: json["desc"],
      rating: (json["rating"] as num).toDouble(),
      harga: json["harga"],
      linkShopee: json["linkShopee"],
    );
  }
}
