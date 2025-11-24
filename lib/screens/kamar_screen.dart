import 'package:flutter/material.dart';
import '../models/kamar.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';

class KamarScreen extends StatefulWidget {
  const KamarScreen({super.key});

  @override
  _KamarScreenState createState() => _KamarScreenState();
}

// Variabel untuk menyimpan daftar kamar yang didapatkan dari API.
// dan controller membaca textfiled
class _KamarScreenState extends State<KamarScreen> {
  List<Kamar> _kamars = [];
  final _tipeController = TextEditingController();
  final _hargaController = TextEditingController();
  final _fasilitasController = TextEditingController();
  final _statusController = TextEditingController();

// Dipanggil sekali saat widget dibuat, digunakan untuk memuat data awal dari API
  @override
  void initState() {
    super.initState();
    _fetchKamars();
  }

  @override
  void dispose() {
    // Membersihkan controller
    _tipeController.dispose();
    _hargaController.dispose();
    _fasilitasController.dispose();
    _statusController.dispose();
    super.dispose();
  }

// Fungsi untuk memuat data kamar dari API. Jika berhasil, data disimpan ke _kamars dan UI diperbarui dengan setState. Jika gagal, pesan error ditampilkan.
  Future<void> _fetchKamars() async {
    try {
      final data = await ApiService.fetchKamars();
      setState(() {
        _kamars = data;
      });
    } catch (e) {
      print('Error fetching kamars: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat data kamar')),
      );
    }
  }

// menambahkan data kamar baru ke backend, lalu memuat ulang data dari API.
  void _addKamar() async {
    if (_tipeController.text.isEmpty ||
        _hargaController.text.isEmpty ||
        _fasilitasController.text.isEmpty ||
        _statusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field')),
      );
      return;
    }

    try {
      Kamar newKamar = Kamar(
        id: 0, // ID auto-increment di backend
        tipeKamar: _tipeController.text,
        hargaPerMalam: double.tryParse(_hargaController.text) ?? 0.0,
        fasilitas: _fasilitasController.text,
        status: _statusController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ApiService.createKamar(newKamar);

      // Bersihkan input setelah berhasil menambahkan
      _tipeController.clear();
      _hargaController.clear();
      _fasilitasController.clear();
      _statusController.clear();

      // Reload data kamar
      _fetchKamars();
    } catch (e) {
      print('Error adding kamar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menambahkan kamar')),
      );
    }
  }

  void _updateKamar(Kamar kamar) async {
    try {
      await ApiService.updateKamar(kamar.id, kamar);
      _fetchKamars(); // Reload data kamar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kamar berhasil diperbarui')),
      );
    } catch (e) {
      print('Error updating kamar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui kamar')),
      );
    }
  }

  void _showEditDialog(Kamar kamar) {
    _tipeController.text = kamar.tipeKamar;
    _hargaController.text = kamar.hargaPerMalam.toString();
    _fasilitasController.text = kamar.fasilitas;
    _statusController.text = kamar.status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Kamar'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                    label: 'Tipe Kamar', controller: _tipeController),
                CustomTextField(
                  label: 'Harga Per Malam',
                  controller: _hargaController,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                    label: 'Fasilitas', controller: _fasilitasController),
                CustomTextField(label: 'Status', controller: _statusController),
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
                final updatedKamar = Kamar(
                  id: kamar.id,
                  tipeKamar: _tipeController.text,
                  hargaPerMalam: double.tryParse(_hargaController.text) ?? 0.0,
                  fasilitas: _fasilitasController.text,
                  status: _statusController.text,
                  createdAt: kamar.createdAt,
                  updatedAt: DateTime.now(),
                );

                _updateKamar(updatedKamar);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteKamar(int id) async {
    try {
      await ApiService.deleteKamar(id);
      _fetchKamars();
    } catch (e) {
      print('Error deleting kamar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus kamar')),
      );
    }
  }

// Tampilan UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kamar Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(label: 'Tipe Kamar', controller: _tipeController),
            CustomTextField(
              label: 'Harga Per Malam',
              controller: _hargaController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
                label: 'Fasilitas', controller: _fasilitasController),
            CustomTextField(label: 'Status', controller: _statusController),
            ElevatedButton(
              onPressed: _addKamar,
              child: const Text('Tambah Kamar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _kamars.length,
                itemBuilder: (context, index) {
                  final kamar = _kamars[index];
                  return ListTile(
                    title: Text(kamar.tipeKamar),
                    subtitle: Text('Rp ${kamar.hargaPerMalam}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditDialog(kamar),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteKamar(kamar.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
