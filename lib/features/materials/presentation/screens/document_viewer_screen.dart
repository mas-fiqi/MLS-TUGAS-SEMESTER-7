import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pengantar User Interface Design",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              "Halaman 1/26",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stimulate a long document page
            Container(
              width: double.infinity,
              height: 800,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                     height: 200,
                     width: double.infinity,
                     color: Colors.grey[200],
                     child: const Center(
                       child: Icon(Icons.image, size: 50, color: Colors.grey),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(24.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(
                           "BAB 1: Pendahuluan",
                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                         ),
                         const SizedBox(height: 16),
                         Text(
                           "User Interface (UI) Design adalah proses yang digunakan desainer untuk membuat tampilan dalam perangkat lunak atau perangkat terkomputerisasi, dengan fokus pada tampilan atau gaya.\n\nTujuannya adalah membuat desain antarmuka yang mudah digunakan, efisien, dan menyenangkan bagi pengguna.\n\n" * 5,
                           style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                           textAlign: TextAlign.justify,
                         ),
                       ],
                     ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
