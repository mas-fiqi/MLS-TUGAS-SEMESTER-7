import 'package:flutter/material.dart';

class MentorCourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> mentor;

  const MentorCourseDetailScreen({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFF3D1C52),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          mentor['role'], // Using role/tech as title
          style: const TextStyle(
            color: Color(0xFF3D1C52),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Banner
            Container(
              margin: const EdgeInsets.all(20),
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2A123A), // Darker purple bg
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.code, // Placeholder for React Logo
                  size: 80,
                  color: Colors.cyanAccent.withOpacity(0.8),
                ),
              ),
            ),

            // 2. Title & Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "${mentor['role']} Complete Course",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D1C52),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Basic guideline & tips & tricks for how to become a Developer easily.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Mentor Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Mentor: ${mentor['name']}",
                        style: const TextStyle(
                          color: Color(0xFF3D1C52),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "105 Videos",
                    style: TextStyle(
                      color: Color(0xFF3D1C52),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Tab Switcher
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5), // Light purple bg
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D1C52),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Videos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text(
                        "Record Session",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3D1C52),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Lesson List
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                bool isLocked = index > 2; // Mock lock status
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                       Container(
                         padding: const EdgeInsets.all(4),
                         decoration: BoxDecoration(
                           color: Colors.redAccent.withOpacity(0.1),
                           shape: BoxShape.circle
                         ),
                         child: const Icon(Icons.play_circle_fill, color: Colors.redAccent, size: 24)
                       ),
                       const SizedBox(width: 12),
                       Expanded(
                         child: Text(
                           "Introduction to ${mentor['role']} Part ${index + 1}",
                           style: const TextStyle(
                             color: Color(0xFF3D1C52),
                             fontSize: 14,
                             fontWeight: FontWeight.w500
                           ),
                         ),
                       ),
                       if (isLocked)
                         const Icon(Icons.lock_outline, color: Colors.grey, size: 20),
                    ],
                  ),
                );
              },
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
