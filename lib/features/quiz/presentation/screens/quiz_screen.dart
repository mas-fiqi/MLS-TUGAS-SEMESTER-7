import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz Review 1",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        leading: Container(), // Hide back button for quiz
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  _formatTime(_remainingSeconds),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Question Navigation Bar
          Container(
            height: 60,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              itemCount: _totalQuestions,
              itemBuilder: (context, index) {
                bool isActive = index == _currentQuestionIndex;
                return Container(
                  width: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isActive ? kPrimaryColor : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? kPrimaryColor : Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Soal Nomor ${_currentQuestionIndex + 1} / $_totalQuestions",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Radio button dapat digunakan untuk menentukan?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Options
                  ...List.generate(5, (index) => _buildOptionCard(index)),
                  
                ],
              ),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 // Previous Button (Hidden if first question)
                _currentQuestionIndex > 0 
                    ? OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _currentQuestionIndex--;
                            _selectedAnswerIndex = -1; // Reset for demo
                          });
                        },
                        child: const Text("Sebelumnya"),
                      )
                    : const SizedBox(),

                ElevatedButton(
                  onPressed: () {
                    if (_currentQuestionIndex < _totalQuestions - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                        _selectedAnswerIndex = -1; // Reset for demo
                      });
                    } else {
                      // Finish quiz
                      Navigator.pop(context);
                      Navigator.pop(context); // Go back to course detail
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(_currentQuestionIndex == _totalQuestions - 1 ? "Selesai" : "Soal Selanjutnya"),
                ),
              ],
            ),
          )
        ],
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

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryColor : Colors.grey[100],
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? kPrimaryColor : Colors.grey[400]!,
                ),
              ),
              child: Center(
                child: Text(
                  _options[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                dummyAnswers[index],
                style: TextStyle(
                  color: isSelected ? kPrimaryColor : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
