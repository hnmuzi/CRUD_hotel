import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kamar.dart';
import '../models/pelanggan.dart';
import '../models/reservasi.dart';

class ApiService {
  static const baseUrl = 'https://zidane.mobilekelasa.my.id/sewa';

  // ---------------- Kamar ----------------
  static Future<List<Kamar>> fetchKamars() async {
    final response = await http.get(Uri.parse('$baseUrl/kamar'));
    if (response.statusCode == 200) {
      return kamarFromJson(response.body);
    } else {
      throw Exception('Gagal memuat daftar kamar: ${response.statusCode}');
    }
  }

  static Future<void> createKamar(Kamar kamar) async {
    final response = await http.post(
      Uri.parse('$baseUrl/kamar/tambah'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kamar.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambah kamar: ${response.body}');
    }
  }

  static Future<void> updateKamar(int id, Kamar kamar) async {
    final response = await http.put(
      Uri.parse('$baseUrl/kamar/rubah/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kamar.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui kamar: ${response.body}');
    }
  }

  static Future<void> deleteKamar(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/kamar/hapus/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus kamar: ${response.body}');
    }
  }

  // ---------------- Pelanggan ----------------
  static Future<List<Pelanggan>> fetchPelanggans() async {
    final response = await http.get(Uri.parse('$baseUrl/pelanggan'));
    if (response.statusCode == 200) {
      return pelangganFromJson(response.body);
    } else {
      throw Exception('Gagal memuat daftar pelanggan: ${response.statusCode}');
    }
  }

  static Future<void> createPelanggan(Pelanggan pelanggan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pelanggan/tambah'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pelanggan.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambah pelanggan: ${response.body}');
    }
  }

  static Future<void> updatePelanggan(int id, Pelanggan pelanggan) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pelanggan/rubah/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pelanggan.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui pelanggan: ${response.body}');
    }
  }

  static Future<void> deletePelanggan(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/pelanggan/hapus/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus pelanggan: ${response.body}');
    }
  }

  // ---------------- Reservasi ----------------
  static Future<List<Reservasi>> fetchReservasis() async {
    final response = await http.get(Uri.parse('$baseUrl/reservasi'));
    if (response.statusCode == 200) {
      return reservasiFromJson(response.body);
    } else {
      throw Exception('Gagal memuat daftar reservasi: ${response.statusCode}');
    }
  }

  static Future<void> createReservasi(Reservasi reservasi) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reservasi/tambah'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reservasi.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambah reservasi: ${response.body}');
    }
  }

  static Future<void> updateReservasi(int id, Reservasi reservasi) async {
    final response = await http.put(
      Uri.parse('$baseUrl/reservasi/rubah/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(reservasi.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui reservasi: ${response.body}');
    }
  }

  static Future<void> deleteReservasi(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/reservasi/hapus/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus reservasi: ${response.body}');
    }
  }
}
