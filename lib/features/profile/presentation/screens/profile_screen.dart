import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../authentication/presentation/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent layout distortion when keyboard opens
      body: Stack(
        children: [
          // 1. Red Header (30% of screen)
          Container(
            height: size.height * 0.35,
            width: double.infinity,
            color: kPrimaryColor,
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8), // Small spacing
                      const Text(
                        "Profil Saya",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48), // Balance
                    ],
                  ),
                  const SizedBox(height: 10), // Reduced spacing
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: kPrimaryColor),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Nama Mahasiswa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "mahasiswa@learning.ac.id",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. White Card (Overlapping)
          Positioned(
            top: size.height * 0.30,
            left: 20,
            right: 20,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: kPrimaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: kPrimaryColor,
                      tabs: [
                        Tab(text: "About Me"),
                        Tab(text: "Kelas"),
                        Tab(text: "Edit"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildAboutMeTab(context),
                          _buildKelasTab(),
                          _buildEditProfileTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem("Email Address", "mahasiswa@learning.ac.id"),
          _buildInfoItem("Program Studi", "Teknik Informatika"),
          _buildInfoItem("Fakultas", "Ilmu Komputer"),
          _buildInfoItem("Aktivitas Login", "Baru saja"),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Log Out"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Force black color
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildKelasTab() {
    return const Center(
      child: Text("Daftar Kelas (Lihat Menu Kelas Saya)"),
    );
  }

  Widget _buildEditProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInput("Nama Pertama", "Mahasiswa"),
          _buildInput("Nama Terakhir", "Satu"),
          _buildInput("Email", "mahasiswa@learning.ac.id"),
          _buildInput("Deskripsi", "Mahasiswa semester 5", maxLines: 3),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, String initialValue, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
