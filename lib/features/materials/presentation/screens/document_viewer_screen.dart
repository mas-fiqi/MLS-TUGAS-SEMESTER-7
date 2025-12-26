import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class DocumentViewerScreen extends StatefulWidget {
  const DocumentViewerScreen({super.key});

  @override
  State<DocumentViewerScreen> createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Real Assets from User Project
  final List<String> _slides = [
    "assets/images/Gemini_Generated_Image_797bn0797bn0797b.png",
    "assets/images/Gemini_Generated_Image_7wfab87wfab87wfa.png",
    "assets/images/Gemini_Generated_Image_9489bp9489bp9489.png",
    "assets/images/Gemini_Generated_Image_ar6y3bar6y3bar6y.png",
    "assets/images/Gemini_Generated_Image_rzlbtmrzlbtmrzlb.png",
     // Reusing for demo length
    "assets/images/Gemini_Generated_Image_797bn0797bn0797b.png",
    "assets/images/Gemini_Generated_Image_7wfab87wfab87wfa.png",
    "assets/images/Gemini_Generated_Image_9489bp9489bp9489.png",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for viewers
      appBar: AppBar(
        title: const Text(
          "Kontrak Kuliah (26 Slides)",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "${_currentPage + 1}/${_slides.length}",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer( // Zoomable
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset(
                        _slides[index],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Bottom Explanation Area (User Request: "Berikan penjelasan Mobile Programming etc")
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            constraints: const BoxConstraints(maxHeight: 250), // Limited height
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Slide ${_currentPage + 1}: Penjelasan Tambahan",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor),
                  ),
                  const SizedBox(height: 8),
                  // Dynamic text based on index or general explanation
                  _buildExplanationText(_currentPage),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExplanationText(int index) {
    // Explanation logic based on user request ("Mobile Programming, IoT, PHP, Python")
    // distributing these topics across slides
    switch (index) {
      case 0:
        return const Text("Mobile Programming adalah pengembangan aplikasi untuk perangkat seluler seperti smartphone dan tablet. Bahasa populer: Dart (Flutter), Kotlin (Android), Swift (iOS).");
      case 1:
        return const Text("Internet of Things (IoT) adalah jaringan perangkat fisik yang terhubung ke internet, saling bertukar data. Contoh: Smart Home, Sensor Industri.");
      case 2:
        return const Text("PHP (Hypertext Preprocessor) adalah bahasa scripting sisi server yang populer untuk pengembangan web. Digunakan untuk membuat website dinamis.");
      case 3:
        return const Text("Python adalah bahasa pemrograman serbaguna yang mudah dibaca. Populer untuk Data Science, AI, Web Development (backend), dan Otomasi.");
      default:
        return const Text("Pelajari materi ini dengan seksama. Geser untuk melihat slide selanjutnya.");
    }
  }
}
