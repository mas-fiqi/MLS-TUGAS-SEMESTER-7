import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'quiz_screen.dart';

class QuizInfoScreen extends StatelessWidget {
  const QuizInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Quiz Review 1",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            // Hero Icon / Illustration
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.quiz_rounded,
                size: 60,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 24),
            
            // Description
            const Text(
              "Pengantar UI/UX",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            const SizedBox(height: 8),
            const Text(
              "Uji pemahaman Anda mengenai materi Pertemuan 1-3. Kerjakan dengan teliti.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 32),

            // Info Grid Cards
            Row(
              children: [
                _buildInfoCard(Icons.timer_outlined, "15 Menit", "Durasi"),
                const SizedBox(width: 16),
                _buildInfoCard(Icons.list_alt_rounded, "15 Soal", "Total"),
                const SizedBox(width: 16),
                _buildInfoCard(Icons.star_outline_rounded, "Tertinggi", "Penilaian"),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // History Section (Clean Look)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Riwayat Percobaan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextColor.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Empty State or List
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                   const Icon(Icons.history_toggle_off, color: Colors.grey, size: 40),
                   const SizedBox(height: 8),
                   Text("Belum ada percobaan", style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            ),
            
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
               color: Colors.black.withOpacity(0.05),
               blurRadius: 20,
               offset: const Offset(0, -5),
            )
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Mulai Kuis",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
             TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Kembali", style: TextStyle(color: Colors.grey)),
             )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.02),
               blurRadius: 10,
               offset: const Offset(0, 4),
             )
          ]
        ),
        child: Column(
          children: [
            Icon(icon, color: kPrimaryColor, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: kTextColor),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
