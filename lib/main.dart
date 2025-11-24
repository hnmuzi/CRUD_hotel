import 'package:flutter/material.dart';
import 'screens/kamar_screen.dart';
import 'screens/pelanggan_screen.dart';
import 'screens/reservasi_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/hotel_background.jpg', // Foto AI hotel
            fit: BoxFit.cover,
          ),
          // Overlay gradient for better visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 1), // Lebih kecil agar lebih ke atas
                // Logo hotel
                Image.asset(
                  'assets/images/hotel_logo.png', // Logo hotel
                  height: 120, // Memperbesar logo sedikit
                  width: 120,
                ),
                const SizedBox(height: 10),
                // Nama hotel
                const Text(
                  'HOTEL SYARIAH',
                  style: TextStyle(
                    fontSize: 30, // Font size sedikit lebih besar
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 110), // Jarak dari tombol
                // Button to manage Kamar
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KamarScreen()),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(
                        color: Colors.black, width: 2), // Outline warna hitam
                  ),
                  child: const Text(
                    "Manage Kamar",
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Warna teks hitam
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Ketebalan teks
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Button to manage Pelanggan
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PelangganScreen()),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(
                        color: Colors.black, width: 2), // Outline warna hitam
                  ),
                  child: const Text(
                    "Manage Pelanggan",
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Warna teks hitam
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Ketebalan teks
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Button to manage Reservasi
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReservasiScreen()),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(
                        color: Colors.black, width: 2), // Outline warna hitam
                  ),
                  child: const Text(
                    "Manage Reservasi",
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Warna teks hitam
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Ketebalan teks
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
