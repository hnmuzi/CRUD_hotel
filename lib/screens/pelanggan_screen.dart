import 'package:flutter/material.dart';
import '../models/pelanggan.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';

class PelangganScreen extends StatefulWidget {
  const PelangganScreen({super.key});

  @override
  _PelangganScreenState createState() => _PelangganScreenState();
}

class _PelangganScreenState extends State<PelangganScreen> {
  List<Pelanggan> _pelanggans = [];
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _teleponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPelanggans();
  }

  @override
  void dispose() {
    // Membersihkan controller
    _namaController.dispose();
    _emailController.dispose();
    _teleponController.dispose();
    super.dispose();
  }

  Future<void> _fetchPelanggans() async {
    try {
      final data = await ApiService.fetchPelanggans();
      setState(() {
        _pelanggans = data;
      });
    } catch (e) {
      print('Error fetching pelanggan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memuat data pelanggan')),
      );
    }
  }

  void _addPelanggan() async {
    if (_namaController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _teleponController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field')),
      );
      return;
    }

    try {
      final newPelanggan = Pelanggan(
        id: 0, // ID auto-increment di backend
        nama: _namaController.text,
        email: _emailController.text,
        telepon: _teleponController.text,
      );

      await ApiService.createPelanggan(newPelanggan);

      // Bersihkan input setelah berhasil menambahkan
      _namaController.clear();
      _emailController.clear();
      _teleponController.clear();

      // Reload data pelanggan
      _fetchPelanggans();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pelanggan berhasil ditambahkan')),
      );
    } catch (e) {
      print('Error adding pelanggan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menambahkan pelanggan')),
      );
    }
  }

  void _updatePelanggan(Pelanggan pelanggan) async {
    try {
      await ApiService.updatePelanggan(pelanggan.id, pelanggan);
      _fetchPelanggans(); // Reload data pelanggan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pelanggan berhasil diperbarui')),
      );
    } catch (e) {
      print('Error updating pelanggan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui pelanggan')),
      );
    }
  }

  void _showEditDialog(Pelanggan pelanggan) {
    _namaController.text = pelanggan.nama;
    _emailController.text = pelanggan.email;
    _teleponController.text = pelanggan.telepon;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Pelanggan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(label: 'Nama', controller: _namaController),
                CustomTextField(label: 'Email', controller: _emailController),
                CustomTextField(
                    label: 'Telepon', controller: _teleponController),
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
                final updatedPelanggan = Pelanggan(
                  id: pelanggan.id,
                  nama: _namaController.text,
                  email: _emailController.text,
                  telepon: _teleponController.text,
                );

                _updatePelanggan(updatedPelanggan);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deletePelanggan(int id) async {
    try {
      await ApiService.deletePelanggan(id);
      _fetchPelanggans();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pelanggan berhasil dihapus')),
      );
    } catch (e) {
      print('Error deleting pelanggan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus pelanggan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pelanggan Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(label: 'Nama', controller: _namaController),
            CustomTextField(label: 'Email', controller: _emailController),
            CustomTextField(label: 'Telepon', controller: _teleponController),
            ElevatedButton(
              onPressed: _addPelanggan,
              child: const Text('Tambah Pelanggan'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _pelanggans.length,
                itemBuilder: (context, index) {
                  final pelanggan = _pelanggans[index];
                  return ListTile(
                    title: Text(pelanggan.nama),
                    subtitle: Text(pelanggan.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditDialog(pelanggan),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletePelanggan(pelanggan.id),
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
