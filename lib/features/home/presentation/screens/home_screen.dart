import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/course_card.dart';
import '../../../../core/theme/theme.dart';
import '../../../classes/presentation/screens/course_detail_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../tasks/presentation/screens/task_detail_screen.dart';
import '../../../tasks/presentation/screens/task_list_screen.dart';

import 'dart:async'; // Add async import for Timer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Dummy announcements data
  // Dummy announcements data
  final List<Map<String, String>> _announcements = [
    {
      'title': 'Jadwal Libur Semester Ganjil',
      'image': 'assets/images/Gemini_Generated_Image_gem5ekgem5ekgem5.png',
    },
    {
      'title': 'Pendaftaran Wisuda Periode 2',
      'image': 'assets/images/Gemini_Generated_Image_m6itaum6itaum6it.png',
    },
    {
      'title': 'Seminar Nasional AI',
      'image': 'assets/images/Gemini_Generated_Image_owd9u0owd9u0owd9.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _announcements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Off-white base
      body: Stack(
        children: [
          // 1. Floating Blobs Background
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFCE93D8), Color(0xFFF48FB1)], // Purple to Pink
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                  colors: [Color(0xFFF06292), Color(0xFFF8BBD0)], // Pink Variants
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: 50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFB39DDB), Color(0xFF9575CD)], // Deep Purple
                ),
              ),
            ),
          ),
          
          // 2. Blur Effect (Glassmorphism Base)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                color: Colors.white.withOpacity(0.3), // Light overlay
              ),
            ),
          ),

          // 3. Foreground Content
          SafeArea(
            child: SingleChildScrollView(
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
                              fontSize: 24,
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
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: kPrimaryColor,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Glass Search Bar
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.black87),
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: 'Cari kelas...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Compact Glass Task Card (Prioritas Tinggi) - RESIZED
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16), // Reduced padding (20 -> 16)
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6), // Glass Effect
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.6)),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.1),
                          blurRadius: 15, // Reduced blur radius slightly
                          offset: const Offset(0, 6), // Reduced offset
                        ),
                      ],
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        GestureDetector(
                          onTap: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Prioritas Tinggi',
                                        style: TextStyle(
                                          color: kPrimaryColor, 
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.more_horiz, color: Colors.grey, size: 20),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Desain Antarmuka Pengguna',
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Tugas 01 - Wireframing',
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: kPrimaryColor.withOpacity(0.7), size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Pengumpulan: Besok, 23:59',
                                      style: TextStyle(color: kPrimaryColor.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Auto-Sliding Announcements Carousel
                  const Text(
                    'Pengumuman Terakhir',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox( // Using SizedBox to constrain PageView height
                    height: 120,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _announcements.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container( // Encapsulate in Container to add margin/spacing between pages if needed
                          margin: const EdgeInsets.only(right: 8), // Tiny margin between slides
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image: AssetImage(_announcements[index]['image']!),
                              fit: BoxFit.cover,
                              opacity: 0.8,
                            ),
                            boxShadow: [
                               BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                   color: Colors.white.withOpacity(0.2),
                                   child: Text(
                                    _announcements[index]['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8), // Spacing for indicator
                  // Page Indicator (Dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _announcements.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? kPrimaryColor : Colors.grey.withOpacity(0.3),
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
                      imagePath: 'assets/images/Gemini_Generated_Image_7wfab87wfab87wfa.png',
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
                      imagePath: 'assets/images/Gemini_Generated_Image_ar6y3bar6y3bar6y.png',
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
                      imagePath: 'assets/images/Gemini_Generated_Image_9489bp9489bp9489.png',
                    ),
                  ),
                  // Bottom Padding to ensure content is not hidden by navbar if transparent
                  const SizedBox(height: 80), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
