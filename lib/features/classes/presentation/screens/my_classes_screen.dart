import 'dart:ui'; // Required for BackdropFilter
import 'package:flutter/material.dart';
import '../../../../shared/widgets/course_card.dart';
import 'course_detail_screen.dart';
import '../../../../core/theme/theme.dart';

class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  // Generate dates for the next 14 days
  final List<DateTime> _dates = List.generate(
      14, (index) => DateTime.now().subtract(const Duration(days: 2)).add(Duration(days: index)));
  int _selectedDateIndex = 2; // Default to "Today"
  String _selectedLanguage = "ID"; // Default Language

  // Real Course Data (Mutable List now)
  // Real Course Data (Mutable List now)
  final List<Map<String, dynamic>> _allActivities = [
    {
      "courseName": "UI/UX Design",
      "startTime": "08:00 AM",
      "endTime": "09:40 AM", 
      "duration": "100 min",
      "initial": "UI",
      "dayOffset": 0, // Today
      "image": "assets/images/Gemini_Generated_Image_797bn0797bn0797b.png"
    },
    {
      "courseName": "Mobile Programming",
      "startTime": "10:00 AM",
      "endTime": "12:30 PM",
      "duration": "150 min", 
      "initial": "MP",
      "dayOffset": 0, // Today
      "image": "assets/images/Gemini_Generated_Image_7wfab87wfab87wfa.png"
    },
    {
      "courseName": "Artificial Intelligence",
      "startTime": "01:00 PM",
      "endTime": "03:00 PM",
      "duration": "120 min",
      "initial": "AI",
      "dayOffset": 1, // Tomorrow
      "image": "assets/images/Gemini_Generated_Image_9489bp9489bp9489.png"
    },
    {
      "courseName": "Data Warehouse",
      "startTime": "08:00 AM",
      "endTime": "10:00 AM",
      "duration": "120 min",
      "initial": "DW", 
      "dayOffset": 2, // Day after tomorrow
      "image": "assets/images/Gemini_Generated_Image_ar6y3bar6y3bar6y.png"
    },
     {
      "courseName": "Cloud Computing",
      "startTime": "03:00 PM",
      "endTime": "05:00 PM",
      "duration": "120 min",
      "initial": "CC", 
      "dayOffset": -1, // Matches Yesterday (index 1) logic if needed, or just random
      "image": "assets/images/Gemini_Generated_Image_rzlbtmrzlbtmrzlb.png"
    },
  ];

  List<Map<String, dynamic>> get _currentActivities {
    int selectedOffset = _selectedDateIndex - 2;
    return _allActivities.where((activity) => activity['dayOffset'] == selectedOffset).toList();
  }

  void _showLanguageModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Pilih Bahasa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildLanguageOption("ID", "Indonesia"),
                  _buildLanguageOption("EN", "English"),
                  _buildLanguageOption("TH", "Thai"),
                  _buildLanguageOption("JP", "Japan"),
                  _buildLanguageOption("CN", "China"),
                  _buildLanguageOption("KR", "Korea"),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String code, String name) {
    bool isSelected = _selectedLanguage == code;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = code;
        });
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? kPrimaryColor.withOpacity(0.1) : Colors.grey[100],
              border: Border.all(color: isSelected ? kPrimaryColor : Colors.transparent, width: 2),
            ),
            child: Center(
              child: Text(code, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? kPrimaryColor : Colors.black87)),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _showAddClassDialog() {
    final TextEditingController nameController = TextEditingController();
    
    // Get Current Time for Defaults
    final now = TimeOfDay.now();
    final oneHourLater = TimeOfDay(hour: (now.hour + 2) % 24, minute: now.minute); // Default 2 hour duration
    
    // Helper to format TimeOfDay to String (e.g. 10:00 AM)
    String formatTime(TimeOfDay time) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute $period';
    }

    final TextEditingController startController = TextEditingController(text: formatTime(now));
    final TextEditingController endController = TextEditingController(text: formatTime(oneHourLater));
    final TextEditingController durationController = TextEditingController(text: "120 min");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Tambah Kelas Baru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nama Mata Kuliah")),
              TextField(controller: startController, decoration: const InputDecoration(labelText: "Jam Mulai (Contoh: 08:00 AM)")),
              TextField(controller: endController, decoration: const InputDecoration(labelText: "Jam Selesai (Contoh: 10:00 AM)")),
              TextField(controller: durationController, decoration: const InputDecoration(labelText: "Durasi (Contoh: 120 min)")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  // Safe Initial Generation (Prevent Crash on short names)
                  String safeInitial = nameController.text.length >= 2 
                      ? nameController.text.substring(0, 2).toUpperCase() 
                      : nameController.text.toUpperCase();
                  
                  // Pick a random image for the new class
                  final List<String> availableImages = [
                    "assets/images/Gemini_Generated_Image_797bn0797bn0797b.png",
                    "assets/images/Gemini_Generated_Image_7wfab87wfab87wfa.png",
                    "assets/images/Gemini_Generated_Image_9489bp9489bp9489.png",
                    "assets/images/Gemini_Generated_Image_ar6y3bar6y3bar6y.png",
                    "assets/images/Gemini_Generated_Image_rzlbtmrzlbtmrzlb.png",
                    "assets/images/Gemini_Generated_Image_7wfab87wfab87wfa.png", // Duplicate for variety weight
                  ];
                  // Use hashcode or random to pick (dart:math not imported? Use list shuffling or simple modulus of name length?)
                  // Or just simple math since I don't want to import dart:math if I can avoid (though it is standard).
                  // I'll import dart:math at top or use simple pseudo-random.
                  // Simple Pseudo:
                  final randomImage = availableImages[DateTime.now().millisecondsSinceEpoch % availableImages.length];

                  setState(() {
                    _allActivities.add({
                      "courseName": nameController.text,
                      "startTime": startController.text,
                      "endTime": endController.text,
                      "duration": durationController.text,
                      "initial": safeInitial,
                      "dayOffset": 0, // Force add to TODAY (0)
                      "image": randomImage, // Assigned Random Image
                    });
                    
                    // Optional: Switch view to Today if not already
                    _selectedDateIndex = 2; 
                  });
                  Navigator.pop(context);
                  
                  // Show feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Kelas berhasil ditambahkan ke Jadwal Hari Ini")),
                  );
                }
              },
             style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              child: const Text("Simpan", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Date String
    DateTime selectedDate = _dates[_selectedDateIndex];
    String dateString = "${selectedDate.day} ${_getMonthName(selectedDate.month)}"; // e.g., 24 June

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Back to Off-white (Glass Theme Base)
      body: Stack(
          children: [
            // FLAGS: 1. Floating Blobs Background (COPIED FROM HOME SCREEN)
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
              child: Column(
                children: [
                  // 1. Header Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row: Month | Language | Add
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _getMonthName(selectedDate.month), // Dynamic Month
                                  style: const TextStyle(
                                    fontSize: 24, 
                                    fontWeight: FontWeight.w500, 
                                    color: Color(0xFF37474F), 
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF37474F)),
                              ],
                            ),
                            Row(
                              children: [
                                // Language Switcher 
                                GestureDetector(
                                  onTap: _showLanguageModal,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6), // Glass
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Text(_selectedLanguage, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Add Button
                                GestureDetector(
                                  onTap: _showAddClassDialog,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6), // Glass
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: const Icon(Icons.add, color: Colors.black87),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Date and Slogan
                         Text(
                          "Hari ini, $dateString",
                          style: const TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                         const Text(
                          "Belajar lebih mudah\nsetiap hari!", 
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF263238), 
                            height: 1.2
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Search Bar (Glass)
                         Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white.withOpacity(0.5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 12),
                              Text(
                                "Cari kelas, tugas, dll...",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 2. Date Picker (Horizontal)
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _dates.length,
                      itemBuilder: (context, index) {
                        final date = _dates[index];
                        final isSelected = index == _selectedDateIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDateIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFF6B6B) : Colors.white.withOpacity(0.7), // Glass inactive
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: isSelected ? [
                                BoxShadow(color: const Color(0xFFFF6B6B).withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
                              ] : [],
                            ),
                            child: Center(
                              child: Text(
                                "${date.day} ${_getMonthShortName(date.month)}", 
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black54,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3. Activity List
                  Expanded(
                    child: _currentActivities.isEmpty 
                    ? const Center(child: Text("Tidak ada kelas pada tanggal ini.", style: TextStyle(color: Colors.black45)))
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      itemCount: _currentActivities.length,
                      itemBuilder: (context, index) {
                        final activity = _currentActivities[index];
                        return GestureDetector(
                           onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CourseDetailScreen(
                                    courseName: activity['courseName'],
                                  ),
                                ),
                              );
                            },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6), // Glass
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white.withOpacity(0.5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Class Image (New) - Always shown for consistency
                                  Container(
                                    width: 60,
                                    height: 60,
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: kPrimaryColor.withOpacity(0.1),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: activity['image'] != null 
                                        ? Image.asset(
                                            activity['image'], 
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Center(
                                                child: Text(
                                                  activity['initial'] ?? '?',
                                                  style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child: Text(
                                              activity['initial'] ?? '?',
                                              style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                                            ),
                                          ),
                                    ),
                                  ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activity['courseName'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF263238),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(child: _buildTimeColumn(activity['startTime'], "Mulai")),
                                          // Time Duration Badge (Centered)
                                           Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 8), // Reduced margins
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.white),
                                            ),
                                            child: Text(
                                              activity['duration'],
                                              style: TextStyle(color: Colors.grey[700], fontSize: 10, fontWeight: FontWeight.bold), // Reduced font
                                            ),
                                          ),
                                          Flexible(child: _buildTimeColumn(activity['endTime'], "Selesai")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Diagonal Arrow
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.arrow_outward, size: 20, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }

  Widget _buildTimeColumn(String time, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF455A64),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
    return months[month - 1];
  }
  
  String _getMonthShortName(int month) {
    const months = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"];
    return months[month - 1];
  }
}
