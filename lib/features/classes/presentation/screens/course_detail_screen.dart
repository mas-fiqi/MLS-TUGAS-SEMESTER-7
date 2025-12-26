import 'dart:ui'; // Added for ImageFilter
import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../quiz/presentation/screens/quiz_info_screen.dart';
import '../../../materials/presentation/screens/video_player_screen.dart';
import '../../../materials/presentation/screens/document_viewer_screen.dart';
import '../../../tasks/presentation/screens/task_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseName;

  const CourseDetailScreen({super.key, required this.courseName});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow body to extend behind AppBar
      appBar: AppBar(
        title: Text(widget.courseName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, // Transparent to show background
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kPrimaryColor.withOpacity(0.8), kPrimaryColor.withOpacity(0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: ClipRRect( // Blur just the app bar area for glass effect
             child: BackdropFilter(
               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
               child: Container(color: Colors.transparent),
             ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: kAccentColor,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: "Materi"),
            Tab(text: "Tugas Dan Kuis"),
          ],
        ),
      ),
      body: Stack(
        children: [
          // 1. Floating Blobs Background (Copied from HomeScreen)
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
          
          // 2. Blur Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                color: Colors.white.withOpacity(0.3), // Light overlay
              ),
            ),
          ),

          // 3. Main Content
          Padding(
            padding: const EdgeInsets.only(top: 140), // Increased to avoid overlap
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMateriTab(),
                _buildTugasTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMateriTab() {
    final List<Map<String, dynamic>> meetings = [
      {
        "title": "Pertemuan 1: Pengantar",
        "subMaterials": [
          {"title": "Kontrak Kuliah", "type": "Document"},
          {"title": "Definisi Dasar UI/UX", "type": "Video", "url": "https://youtu.be/poZtdyC24P4"},
        ],
        "completed": true,
      },
      {
        "title": "Pertemuan 2: Konsep Dasar",
        "subMaterials": [
          {"title": "Sejarah UI Design", "type": "Document"},
          {"title": "Perkembangan Teknologi", "type": "Video", "url": "https://youtu.be/W5LPcpIRLzs"},
        ],
        "completed": true,
      },
      {
        "title": "Pertemuan 3: Implementasi",
        "subMaterials": [
          {"title": "Studi Kasus Aplikasi", "type": "Document"},
          {"title": "Latihan Wireframing", "type": "Video", "url": "https://youtu.be/RuNPg-HuEyY"},
        ],
        "completed": false,
      },
      {
        "title": "Pertemuan 4",
        "subMaterials": [
          {"title": "Materi Lanjutan", "type": "Video", "url": "https://youtu.be/yCB144mK_xc"},
           {"title": "Studi Kasus 2", "type": "Video", "url": "https://youtu.be/LcDjP3cdk0g"},
        ],
        "completed": false,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: meetings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final meeting = meetings[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24), // Highly rounded
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E0E0).withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: const Border(),
              collapsedShape: const Border(),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5), // Light grey background for icon
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.folder_copy_outlined, color: Colors.black87, size: 22),
              ),
              title: Text(
                meeting['title'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
              subtitle: Text(
                "${(meeting['subMaterials'] as List).length} Materi",
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
              children: (meeting['subMaterials'] as List<Map<String, String>>).map((sub) {
                bool isVideo = sub['type'] == 'Video';
                return Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  decoration: BoxDecoration(
                     color: Colors.grey[50],
                     borderRadius: BorderRadius.circular(16)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(sub['title']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: isVideo ? const Text("Video Pembelajaran", style: TextStyle(fontSize: 12, color: Colors.grey)) : const Text("Dokumen PDF", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isVideo ? const Color(0xFFFFEBEE) : const Color(0xFFE3F2FD),
                        shape: BoxShape.circle
                      ),
                      child: Icon(
                        isVideo ? Icons.play_arrow_rounded : Icons.article_rounded,
                        color: isVideo ? Colors.redAccent : Colors.blueAccent,
                         size: 20,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
                    onTap: () async {
                      if (isVideo && sub['url'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              startUrl: sub['url']!,
                              startTitle: sub['title']!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DocumentViewerScreen()),
                        );
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTugasTab() {
    final List<Map<String, String>> assignments = [
      {
        "title": "Tugas 1: Analisis Kasus",
        "deadline": "Deadline: 25 Des 2024",
        "matchRate": "94% Completed", // Mimicking "Match Rate" from image
        "type": "Assignment",
        "color": "0xFFE8F5E9", // Green tint
        "progressColor": "0xFF4CAF50"
      },
      {
        "title": "Kuis 1: Pilihan Ganda",
        "deadline": "Deadline: 28 Des 2024",
        "matchRate": "87% Completed",
        "type": "Quiz",
        "color": "0xFFFFF3E0", // Orange tint
        "progressColor": "0xFFFF9800"
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: assignments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = assignments[index];
        bool isQuiz = item['type'] == "Quiz";
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E0E0).withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
               if (isQuiz) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizInfoScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
                );
              }
            },
            child: Column(
              children: [
                Row(
                  children: [
                    // Avatar/Icon
                    Container(
                       width: 50, 
                       height: 50,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: const DecorationImage(
                           image: AssetImage('assets/images/logo.png'), // Placeholder or use icon
                           fit: BoxFit.cover,
                           opacity: 0.8
                         ),
                         // Fallback if image not found (using color)
                         color: Colors.grey[200]
                       ),
                       child: const Icon(Icons.person, color: Colors.grey), // Fallback
                    ),
                    const SizedBox(width: 16),
                    // Title & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['type']!, // "Assignment" or "Quiz"
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.arrow_outward_rounded, size: 20, color: Colors.black54),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                
                // Progress Bar Section (Mimicking "Match Rate")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['deadline']!.replaceFirst('Deadline: ', 'Tenggat: '),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                     // Chat/Call Icons (Mimic)
                    Row(
                      children: [
                        _buildSmallIcon(Icons.chat_bubble_outline_rounded),
                        const SizedBox(width: 8),
                        _buildSmallIcon(Icons.notifications_none_rounded),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                // Progress Indicator
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: isQuiz ? 0.87 : 0.94,
                    color: Color(int.parse(item['progressColor']!)),
                    backgroundColor: Color(int.parse(item['color']!)),
                    minHeight: 6,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmallIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
         boxShadow: [
           BoxShadow(
             color: Colors.black12,
             blurRadius: 5,
             offset: Offset(0, 2)
           )
         ]
      ),
      child: Icon(icon, size: 16, color: Colors.black54),
    );
  }
}
