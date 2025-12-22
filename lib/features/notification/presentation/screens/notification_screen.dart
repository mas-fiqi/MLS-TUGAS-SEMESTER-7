import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "title": "Tugas Dikirim",
      "message": "Anda telah mengirimkan tugas Mobile Programming.",
      "time": "5 Menit Lalu",
      "type": "assignment"
    },
    {
      "title": "Materi Baru",
      "message": "Dosen mengunggah materi baru di kelas UI/UX.",
      "time": "1 Jam Lalu",
      "type": "material"
    },
    {
      "title": "Pengingat Kuis",
      "message": "Kuis Sistem Operasi akan dimulai besok pagi.",
      "time": "5 Jam Lalu",
      "type": "quiz"
    },
    {
      "title": "Pengumuman",
      "message": "Jadwal libur semester telah diperbarui.",
      "time": "1 Hari Lalu",
      "type": "info"
    },
    {
      "title": "Nilai Keluar",
      "message": "Nilai UTS Bahasa Inggris Anda sudah keluar.",
      "time": "3 Hari 9 Jam Yang Lalu",
      "type": "grade"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          IconData icon;
          Color color;
          
          switch (notif['type']) {
            case 'assignment':
              icon = Icons.assignment_turned_in;
              color = Colors.green;
              break;
            case 'quiz':
              icon = Icons.quiz;
              color = Colors.orange;
              break;
            case 'material':
              icon = Icons.book;
              color = Colors.blue;
              break;
            case 'grade':
              icon = Icons.grade;
              color = Colors.purple;
              break;
            default:
              icon = Icons.notifications;
              color = Colors.grey;
          }

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            title: Text(
              notif['message']!, // Using message as main title based on description "Teks pesan"
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                notif['time']!,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
