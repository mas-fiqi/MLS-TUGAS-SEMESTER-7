import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Daftar Tugas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        fit: StackFit.expand,
        children: [
            // Blob Background (Consistent with Theme)
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
            
            ListView(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
              children: [
                _buildTaskItem(context, "Desain Antarmuka", "Tugas 01 - Wireframe", "Besok, 23:59", Colors.orange),
                _buildTaskItem(context, "Pemrograman Mobile", "Projek Akhir", "7 Hari lagi", Colors.blue),
                _buildTaskItem(context, "Basis Data", "Normalisasi", "2 Hari lagi", Colors.red),
                _buildTaskItem(context, "Kecerdasan Buatan", "Quiz 1", "Selesai", Colors.green),
              ],
            )
        ]
      )
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, String subtitle, String time, Color timeColor) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TaskDetailScreen())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
             BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.assignment, color: kPrimaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 Icon(Icons.access_time, size: 16, color: timeColor),
                 const SizedBox(height: 4),
                 Text(time, style: TextStyle(color: timeColor, fontSize: 12, fontWeight: FontWeight.bold)),
               ],
            )
          ],
        ),
      ),
    );
  }
}
