import 'package:flutter/material.dart';
import '../../../../shared/widgets/course_card.dart';
import '../../../../core/theme/theme.dart';
import '../../../classes/presentation/screens/course_detail_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Selamat Datang,',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    'Mahasiswa',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 24,
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Red Task Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Prioritas Tinggi',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Desain Antarmuka Pengguna',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tugas 01 - Wireframing',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.access_time, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Pengumpulan: Besok, 23:59',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Announcements
          const Text(
            'Pengumuman Terakhir',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/kampus.png'),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
            child: Center(
              child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 color: Colors.black54,
                 child: const Text(
                  'Jadwal Libur Semester Ganjil',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Course Progress
          const Text(
            'Progres Kelas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // List of Course Cards
          // List of Course Cards
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourseDetailScreen(
                    courseName: 'Pemrograman Mobile',
                  ),
                ),
              );
            },
            child: const CourseCard(
              courseName: 'Pemrograman Mobile',
              lecturerCode: 'DSN-001',
              initial: 'PM',
              progress: 0.75,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourseDetailScreen(
                    courseName: 'Basis Data Lanjut',
                  ),
                ),
              );
            },
            child: const CourseCard(
              courseName: 'Basis Data Lanjut',
              lecturerCode: 'DSN-005',
              initial: 'BD',
              progress: 0.45,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourseDetailScreen(
                    courseName: 'Kecerdasan Buatan',
                  ),
                ),
              );
            },
            child: const CourseCard(
              courseName: 'Kecerdasan Buatan',
              lecturerCode: 'DSN-003',
              initial: 'AI',
              progress: 0.10,
            ),
          ),
        ],
      ),
    );
  }
}
