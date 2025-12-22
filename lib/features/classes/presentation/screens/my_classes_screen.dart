import 'package:flutter/material.dart';
import '../../../../shared/widgets/course_card.dart';
import 'course_detail_screen.dart';

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({super.key});

  final List<Map<String, dynamic>> courses = const [
    {
      "courseName": "UI/UX Design",
      "lecturerCode": "MK001",
      "initial": "UI",
      "progress": 0.75
    },
    {
      "courseName": "Kewarganegaraan",
      "lecturerCode": "MK002",
      "initial": "PKN",
      "progress": 0.45
    },
    {
      "courseName": "Sistem Operasi",
      "lecturerCode": "MK003",
      "initial": "SO",
      "progress": 0.60
    },
    {
      "courseName": "Mobile Programming",
      "lecturerCode": "MK004",
      "initial": "MP",
      "progress": 0.30
    },
    {
      "courseName": "Multimedia",
      "lecturerCode": "MK005",
      "initial": "MM",
      "progress": 0.90
    },
    {
      "courseName": "Bahasa Inggris",
      "lecturerCode": "MK006",
      "initial": "ENG",
      "progress": 0.20
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kelas Saya",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(
                    courseName: course['courseName'],
                  ),
                ),
              );
            },
            child: CourseCard(
              courseName: course['courseName'],
              lecturerCode: course['lecturerCode'],
              initial: course['initial'],
              progress: course['progress'],
            ),
          );
        },
      ),
    );
  }
}
