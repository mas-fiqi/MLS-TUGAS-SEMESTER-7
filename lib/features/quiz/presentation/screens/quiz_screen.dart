import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'quiz_result_screen.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _selectedAnswerIndex = -1;
  late Timer _timer;
  int _remainingSeconds = 900; // 15 minutes

  final int _totalQuestions = 15;
  final List<String> _options = ['A', 'B', 'C', 'D', 'E'];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex + 1) / _totalQuestions;

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light grey background
      body: SafeArea(
        child: Column(
          children: [
            // 1. Modern Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Progress Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "Pertanyaan ${_currentQuestionIndex + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: kTextColor),
                      ),
                       Text(
                        "dari $_totalQuestions Soal",
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                  
                  // Timer Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined, color: kPrimaryColor, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          _formatTime(_remainingSeconds),
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            // Linear Progress Bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor),
              minHeight: 4,
            ),

            // 2. Question & Options Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question Card
                    const Text(
                       "Radio button dapat digunakan untuk menentukan?",
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w600,
                         color: kTextColor,
                         height: 1.4,
                       ),
                    ),
                    const SizedBox(height: 32),

                    // Options List
                     ...List.generate(5, (index) => _buildOptionCard(index)),
                  ],
                ),
              ),
            ),

            // 3. Navigation Bar
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 20,
                  )
                ]
              ),
              child: Row(
                children: [
                  // Prev Button
                  if (_currentQuestionIndex > 0)
                    IconButton(
                        onPressed: () {
                           setState(() {
                            _currentQuestionIndex--;
                            _selectedAnswerIndex = -1;
                          });
                        },
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
                         style: IconButton.styleFrom(
                           backgroundColor: Colors.grey[100],
                           padding: const EdgeInsets.all(12),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         ),
                    ),
                  
                  if (_currentQuestionIndex > 0)
                     const SizedBox(width: 16),

                  // Next Button
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentQuestionIndex < 14) {
                            setState(() {
                              _currentQuestionIndex++;
                              _selectedAnswerIndex = -1;
                            });
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const QuizResultScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          _currentQuestionIndex == _totalQuestions - 1 ? "Selesaikan Kuis" : "Selanjutnya",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(int index) {
    bool isSelected = _selectedAnswerIndex == index;
    List<String> dummyAnswers = [
      "Banyak pilihan dan banyak opsi yang dipilih",
      "Banyak pilihan dan hanya satu opsi yang dipilih",
      "Satu pilihan dan banyak opsi yang dipilih",
      "Hanya digunakan untuk input teks",
      "Tidak ada jawaban yang benar"
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedAnswerIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryColor.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.grey[200]!,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected ? [] : [
               BoxShadow(
                 color: Colors.black.withOpacity(0.02),
                 blurRadius: 10,
                 offset: const Offset(0, 4),
               )
            ],
          ),
          child: Row(
            children: [
               // Letter Indicator
               Container(
                 width: 36,
                 height: 36,
                 decoration: BoxDecoration(
                   color: isSelected ? kPrimaryColor : Colors.grey[100],
                   borderRadius: BorderRadius.circular(10), // Rounded square
                 ),
                 child: Center(
                   child: Text(
                     _options[index],
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: isSelected ? Colors.white : Colors.grey[600],
                     ),
                   ),
                 ),
               ),
               const SizedBox(width: 16),
               
               // Answer Text
               Expanded(
                 child: Text(
                   dummyAnswers[index],
                   style: TextStyle(
                     fontSize: 15,
                     color: isSelected ? Colors.black87 : Colors.grey[800],
                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                   ),
                 ),
               ),
               
               // Checkmark
               if (isSelected)
                  const Icon(Icons.check_circle_rounded, color: kPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
