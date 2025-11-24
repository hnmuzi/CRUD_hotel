import 'package:flutter/material.dart';
import '../models/reservasi.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';

class ReservasiScreen extends StatefulWidget {
  const ReservasiScreen({super.key});

  @override
  _ReservasiScreenState createState() => _ReservasiScreenState();
}

class _ReservasiScreenState extends State<ReservasiScreen> {
  List<Reservasi> _reservasis = [];
  final _pelangganIdController = TextEditingController();
  final _kamarIdController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _jumlahKamarController = TextEditingController();
  final _totalHargaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchReservasis();
  }

  @override
  void dispose() {
    // Membersihkan controller
    _pelangganIdController.dispose();
    _kamarIdController.dispose();
    _tanggalController.dispose();
    _jumlahKamarController.dispose();
    _totalHargaController.dispose();
    super.dispose();
  }

  Future<void> _fetchReservasis() async {
    try {
      final data = await ApiService.fetchReservasis();
      setState(() {
        _reservasis = data;
      });
    } catch (e) {
      print('Error fetching reservasi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data reservasi: $e')),
      );
    }
  }

  void _addReservasi() async {
    if (_pelangganIdController.text.isEmpty ||
        _kamarIdController.text.isEmpty ||
        _tanggalController.text.isEmpty ||
        _jumlahKamarController.text.isEmpty ||
        _totalHargaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field')),
      );
      return;
    }

    try {
      final newReservasi = Reservasi(
        id: 0, // ID auto-increment di backend
        pelangganId: int.parse(_pelangganIdController.text),
        kamarId: int.parse(_kamarIdController.text),
        tanggalReservasi: _tanggalController.text,
        jumlahKamar: int.parse(_jumlahKamarController.text),
        totalHarga: double.parse(_totalHargaController.text),
      );

      await ApiService.createReservasi(newReservasi);

      // Bersihkan input setelah berhasil menambahkan
      _pelangganIdController.clear();
      _kamarIdController.clear();
      _tanggalController.clear();
      _jumlahKamarController.clear();
      _totalHargaController.clear();

      // Reload data reservasi
      _fetchReservasis();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservasi berhasil ditambahkan')),
      );
    } catch (e) {
      print('Error adding reservasi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan reservasi: $e')),
      );
    }
  }

  void _deleteReservasi(int id) async {
    try {
      await ApiService.deleteReservasi(id);
      _fetchReservasis();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservasi berhasil dihapus')),
      );
    } catch (e) {
      print('Error deleting reservasi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus reservasi: $e')),
      );
    }
  }

  void _showEditDialog(Reservasi reservasi) {
    // Mengisi controller dengan data yang akan diedit
    _pelangganIdController.text = reservasi.pelangganId.toString();
    _kamarIdController.text = reservasi.kamarId.toString();
    _tanggalController.text = reservasi.tanggalReservasi;
    _jumlahKamarController.text = reservasi.jumlahKamar.toString();
    _totalHargaController.text = reservasi.totalHarga.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Reservasi'),
          content: SingleChildScrollView(
            // Tambahkan SingleChildScrollView di sini
            child: Column(
              children: [
                CustomTextField(
                  label: 'ID Pelanggan',
                  controller: _pelangganIdController,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: 'ID Kamar',
                  controller: _kamarIdController,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: 'Tanggal Reservasi',
                  controller: _tanggalController,
                ),
                CustomTextField(
                  label: 'Jumlah Kamar',
                  controller: _jumlahKamarController,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: 'Total Harga',
                  controller: _totalHargaController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup dialog
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                final updatedReservasi = Reservasi(
                  id: reservasi.id,
                  pelangganId: int.parse(_pelangganIdController.text),
                  kamarId: int.parse(_kamarIdController.text),
                  tanggalReservasi: _tanggalController.text,
                  jumlahKamar: int.parse(_jumlahKamarController.text),
                  totalHarga: double.parse(_totalHargaController.text),
                );

                _updateReservasi(updatedReservasi);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _updateReservasi(Reservasi reservasi) async {
    try {
      await ApiService.updateReservasi(reservasi.id, reservasi);
      _fetchReservasis(); // Reload data reservasi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservasi berhasil diperbarui')),
      );
    } catch (e) {
      print('Error updating reservasi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui reservasi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservasi Management')),
      body: SingleChildScrollView(
        // Tambahkan SingleChildScrollView di layar utama
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                label: 'ID Pelanggan',
                controller: _pelangganIdController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: 'ID Kamar',
                controller: _kamarIdController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: 'Tanggal Reservasi',
                controller: _tanggalController,
              ),
              CustomTextField(
                label: 'Jumlah Kamar',
                controller: _jumlahKamarController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                label: 'Total Harga',
                controller: _totalHargaController,
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _addReservasi,
                child: const Text('Tambah Reservasi'),
              ),
              const SizedBox(height: 20),
              _reservasis.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _reservasis.length,
                      itemBuilder: (context, index) {
                        final reservasi = _reservasis[index];
                        return ListTile(
                          title: Text('Reservasi ID: ${reservasi.id}'),
                          subtitle: Text(
                            'Pelanggan ID: ${reservasi.pelangganId}\n'
                            'Kamar ID: ${reservasi.kamarId}\n'
                            'Tanggal: ${reservasi.tanggalReservasi}\n'
                            'Jumlah: ${reservasi.jumlahKamar}\n'
                            'Total Harga: ${reservasi.totalHarga}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showEditDialog(reservasi),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteReservasi(reservasi.id),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
