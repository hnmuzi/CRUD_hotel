import 'dart:convert';

List<Reservasi> reservasiFromJson(String str) => List<Reservasi>.from(
      json.decode(str).map((x) => Reservasi.fromJson(x)),
    );

String reservasiToJson(List<Reservasi> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class Reservasi {
  final int id;
  final int pelangganId;
  final int kamarId;
  final String tanggalReservasi;
  final int jumlahKamar;
  final double totalHarga;

  Reservasi({
    required this.id,
    required this.pelangganId,
    required this.kamarId,
    required this.tanggalReservasi,
    required this.jumlahKamar,
    required this.totalHarga,
  });

  factory Reservasi.fromJson(Map<String, dynamic> json) {
    return Reservasi(
      id: json['id'],
      pelangganId: json['pelanggan_id'],
      kamarId: json['kamar_id'],
      tanggalReservasi: json['tanggal_reservasi'],
      jumlahKamar: json['jumlah_kamar'],
      totalHarga: json['total_harga'] is String
          ? double.tryParse(json['total_harga']) ?? 0.0
          : (json['total_harga'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pelanggan_id': pelangganId,
      'kamar_id': kamarId,
      'tanggal_reservasi': tanggalReservasi,
      'jumlah_kamar': jumlahKamar,
      'total_harga': totalHarga,
    };
  }
}
