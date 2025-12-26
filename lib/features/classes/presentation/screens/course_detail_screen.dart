import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../quiz/presentation/screens/quiz_info_screen.dart';
import '../../../materials/presentation/screens/video_player_screen.dart';
import '../../../materials/presentation/screens/document_viewer_screen.dart';
import '../../../tasks/presentation/screens/task_detail_screen.dart';

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
      appBar: AppBar(
        title: Text(widget.courseName, style: const TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: kAccentColor,
          tabs: const [
            Tab(text: "Materi"),
            Tab(text: "Tugas Dan Kuis"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMateriTab(),
          _buildTugasTab(),
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
          {"title": "Definisi Dasar UI/UX", "type": "Video"},
        ],
        "completed": true,
      },
      {
        "title": "Pertemuan 2: Konsep Dasar",
        "subMaterials": [
          {"title": "Sejarah UI Design", "type": "Document"},
          {"title": "Perkembangan Teknologi", "type": "Video"},
        ],
        "completed": true,
      },
      {
        "title": "Pertemuan 3: Implementasi",
        "subMaterials": [
          {"title": "Studi Kasus Aplikasi", "type": "Document"},
          {"title": "Latihan Wireframing", "type": "Video"},
        ],
        "completed": false,
      },
      {
        "title": "Pertemuan 4",
        "subMaterials": [
          {"title": "Materi Lanjutan", "type": "Document"},
        ],
        "completed": false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meetings.length,
      itemBuilder: (context, index) {
        final meeting = meetings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              meeting['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: (meeting['subMaterials'] as List<Map<String, String>>).map((sub) {
              bool isVideo = sub['type'] == 'Video';
              return ListTile(
                title: Text(sub['title']!),
                leading: Icon(
                  isVideo ? Icons.play_circle_outline : Icons.description_outlined,
                  color: isVideo ? Colors.redAccent : Colors.blueAccent,
                ),
                trailing: meeting['completed']
                    ? const Icon(Icons.check_circle, color: kAccentColor)
                    : const Icon(Icons.circle_outlined, color: Colors.grey),
                onTap: () {
                  if (isVideo) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VideoPlayerScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DocumentViewerScreen()),
                    );
                  }
                },
              );
            }).toList(),
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
        "type": "Assignment"
      },
      {
        "title": "Kuis 1: Pilihan Ganda",
        "deadline": "Deadline: 28 Des 2024",
        "type": "Quiz"
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final item = assignments[index];
        bool isQuiz = item['type'] == "Quiz";
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Icon Box
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isQuiz ? Colors.orange : Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isQuiz ? Icons.quiz : Icons.assignment,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['deadline']!.replaceFirst('Deadline: ', 'Tenggat: '),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Navigation Arrow
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
