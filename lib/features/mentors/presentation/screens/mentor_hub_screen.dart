import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'mentor_course_detail_screen.dart';
import 'dart:ui';
import '../../../notification/presentation/screens/notification_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class MentorHubScreen extends StatefulWidget {
  const MentorHubScreen({super.key});

  @override
  State<MentorHubScreen> createState() => _MentorHubScreenState();
}

class _MentorHubScreenState extends State<MentorHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Dummy Data
  final List<Map<String, dynamic>> _allMentors = const [
    {"name": "Lisa Rahman", "role": "UI/UX Designer"},
    {"name": "Charli Fallon", "role": "React"},
    {"name": "Jennifer", "role": "Java Script"},
    {"name": "Susan James", "role": "Python"},
    {"name": "Kathleen Krier", "role": "Flutter"},
    {"name": "Edward Odell", "role": "Node.js"},
  ];

  List<Map<String, dynamic>> _filteredMentors = [];

  @override
  void initState() {
    super.initState();
    _filteredMentors = _allMentors;
  }

  void _filterMentors(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMentors = _allMentors;
      } else {
        _filteredMentors = _allMentors
            .where((mentor) =>
                mentor['name'].toLowerCase().contains(query.toLowerCase()) ||
                mentor['role'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Light Greyish White
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
                  colors: [Color(0xFF90CAF9), Color(0xFF80DEEA)], // Blue to Cyan
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
           Positioned(
            bottom: -50,
            left: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFFF59D), Color(0xFFFFCC80)], // Yellow to Orange
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
           // 2. Blur Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: Colors.white.withOpacity(0.3), // Glassy white overlay
              ),
            ),
          ),

          // 3. Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage('assets/images/logo.png'), // Placeholder
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Rumi Aktar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF3D1C52), // Dark Purple
                                  ),
                                ),
                                Text(
                                  "Let's learn something new",
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF3D1C52),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 2. Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: _filterMentors,
                                  decoration: const InputDecoration(
                                    hintText: "Search Mentor",
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D1C52),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 3. Top Mentor Title
                  const Text(
                    "Top Mentor",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D1C52),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Mentor Grid
                  _filteredMentors.isEmpty
                      ? const Center(child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Mentor tidak ditemukan", style: TextStyle(color: Colors.grey)),
                        ))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 columns as per reference
                            childAspectRatio: 0.75, // Adjust height/width ratio
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: _filteredMentors.length,
                          itemBuilder: (context, index) {
                            return _buildMentorCard(context, _filteredMentors[index]);
                          },
                        ),
                 
                  const SizedBox(height: 24),
                   // 5. Mentor (Additional Section)
                  const Text(
                    "Mentor",
                     style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D1C52),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Reuse filtered list for demo purposes, or can filter differently
                   _filteredMentors.isEmpty
                      ? const SizedBox() 
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: _filteredMentors.length, 
                          itemBuilder: (context, index) {
                             return _buildMentorCard(context, _filteredMentors[index]);
                          },
                        ),
                  const SizedBox(height: 80), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorCard(BuildContext context, Map<String, dynamic> mentor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MentorCourseDetailScreen(mentor: mentor),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/logo.png'), // Placeholder
              backgroundColor: Colors.grey.shade100, // Fallback
              child: const Icon(Icons.person, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              mentor['name'],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF3D1C52),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mentor['role'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return const Icon(Icons.star, color: Colors.amber, size: 10);
              }),
            )
          ],
        ),
      ),
    );
  }
}
