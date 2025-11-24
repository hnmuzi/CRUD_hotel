import 'dart:convert';

List<Kamar> kamarFromJson(String str) =>
    List<Kamar>.from(json.decode(str).map((x) => Kamar.fromJson(x)));

String kamarToJson(List<Kamar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kamar {
  final int id;
  final String tipeKamar;
  final double hargaPerMalam;
  final String fasilitas;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Kamar({
    required this.id,
    required this.tipeKamar,
    required this.hargaPerMalam,
    required this.fasilitas,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kamar.fromJson(Map<String, dynamic> json) {
    return Kamar(
      id: json["id"],
      tipeKamar: json["tipe_kamar"],
      hargaPerMalam: json["harga_per_malam"] is String
          ? double.tryParse(json["harga_per_malam"]) ?? 0.0
          : (json["harga_per_malam"] as num).toDouble(),
      fasilitas: json["fasilitas"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "tipe_kamar": tipeKamar,
      "harga_per_malam": hargaPerMalam,
      "fasilitas": fasilitas,
      "status": status,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
