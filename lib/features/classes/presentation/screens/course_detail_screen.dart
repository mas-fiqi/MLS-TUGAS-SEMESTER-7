import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../quiz/presentation/screens/quiz_info_screen.dart';

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
        "subMaterials": ["Kontrak Kuliah", "Definisi Dasar"],
        "completed": true,
      },
      {
        "title": "Pertemuan 2: Konsep Dasar",
        "subMaterials": ["Sejarah", "Perkembangan"],
        "completed": true,
      },
      {
        "title": "Pertemuan 3: Implementasi",
        "subMaterials": ["Studi Kasus", "Latihan"],
        "completed": false,
      },
      {
        "title": "Pertemuan 4",
        "subMaterials": ["Materi Lanjutan"],
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
            children: (meeting['subMaterials'] as List<String>).map((sub) {
              return ListTile(
                title: Text(sub),
                leading: const Icon(Icons.description_outlined, color: Colors.grey),
                trailing: meeting['completed']
                    ? const Icon(Icons.check_circle, color: kAccentColor)
                    : const Icon(Icons.circle_outlined, color: Colors.grey),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isQuiz ? Colors.purple.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              child: Icon(
                isQuiz ? Icons.quiz_outlined : Icons.assignment_outlined,
                color: isQuiz ? Colors.purple : Colors.orange,
              ),
            ),
            title: Text(
              item['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item['deadline']!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              if (item['type'] == "Quiz") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizInfoScreen()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
