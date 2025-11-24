import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label; // Label untuk input field
  final TextEditingController
      controller; // Controller untuk menangkap input teks
  final TextInputType keyboardType; // Tipe keyboard, default TextInputType.text
  final bool isPassword; // Untuk field password (opsional)

  const CustomTextField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword, // True jika field adalah password
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
