import 'dart:convert';

List<Pelanggan> pelangganFromJson(String str) =>
    List<Pelanggan>.from(json.decode(str).map((x) => Pelanggan.fromJson(x)));

String pelangganToJson(List<Pelanggan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pelanggan {
  final int id;
  final String nama;
  final String email;
  final String telepon;

  Pelanggan({
    required this.id,
    required this.nama,
    required this.email,
    required this.telepon,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: json["id"],
      nama: json["nama"],
      email: json["email"],
      telepon: json["telepon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "email": email,
      "telepon": telepon,
    };
  }
}
