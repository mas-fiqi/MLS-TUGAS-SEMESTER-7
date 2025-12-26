import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // Placeholder for file selection
  String? _selectedFile;

  void _pickFile() {
    setState(() {
      _selectedFile = "Tugas_Wireframe.pdf"; // Simulating file pick
    });
  }

  void _submitTask() {
    if (_selectedFile == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tugas berhasil dikumpulkan!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Pengumpulan Tugas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: kPrimaryColor.withOpacity(0.7)),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand, // Ensure bg fills
        children: [
           // Blobs Background (Consistent with Theme)
           Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFCE93D8), Color(0xFFF48FB1)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFF06292), Color(0xFFF8BBD0)],
                ),
              ),
            ),
          ),
           Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.white.withOpacity(0.3)), // Light overlay
            ),
          ),

           SafeArea(
             child: SingleChildScrollView(
               padding: const EdgeInsets.all(24),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // Task Info Card
                   Container(
                     padding: const EdgeInsets.all(24),
                     decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.6),
                       borderRadius: BorderRadius.circular(24),
                       border: Border.all(color: Colors.white.withOpacity(0.5)),
                       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                               decoration: BoxDecoration(
                                 color: kPrimaryColor.withOpacity(0.1),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: const Text("Tugas 01", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                             ),
                             const Spacer(),
                             const Icon(Icons.timer, size: 16, color: Colors.orange),
                             const SizedBox(width: 4),
                             const Text("Besok, 23:59", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                           ],
                         ),
                         const SizedBox(height: 16),
                         const Text("Desain Antarmuka Pengguna", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextColor)),
                         const SizedBox(height: 8),
                         const Text("Buatlah wireframe aplikasi mobile untuk halaman Login da Dashboard menggunakan Figma.", style: TextStyle(fontSize: 16, color: Colors.black54)),
                       ],
                     ),
                   ),
                   const SizedBox(height: 32),

                   // Upload Section
                   const Text("Upload File", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
                   const SizedBox(height: 16),
                   GestureDetector(
                     onTap: _pickFile,
                     child: Container(
                       height: 150,
                       width: double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.white.withOpacity(0.4),
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(color: kPrimaryColor.withOpacity(0.5), width: 1.5), 
                       ),
                       child: _selectedFile == null 
                         ? Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: const [
                               Icon(Icons.cloud_upload_outlined, size: 48, color: kPrimaryColor),
                               SizedBox(height: 8),
                               Text("Tap untuk upload tugas", style: TextStyle(color: kPrimaryColor)),
                             ],
                           )
                         : Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               const Icon(Icons.check_circle, size: 48, color: Colors.green),
                               const SizedBox(height: 8),
                               Text(_selectedFile!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                               const Text("Tap untuk ganti file", style: TextStyle(color: Colors.grey, fontSize: 12)),
                             ],
                           ),
                     ),
                   ),
                   const SizedBox(height: 40),

                   // Submit Button
                   SizedBox(
                     width: double.infinity,
                     height: 56,
                     child: ElevatedButton(
                       onPressed: _selectedFile != null ? _submitTask : null,
                       style: ElevatedButton.styleFrom(
                         backgroundColor: kPrimaryColor,
                         elevation: 5,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                         shadowColor: kPrimaryColor.withOpacity(0.4),
                       ),
                       child: const Text("Kumpulkan Tugas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                     ),
                   ),
                 ],
               ),
             ),
           ),
        ],
      ),
    );
  }
}
