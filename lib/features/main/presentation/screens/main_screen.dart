import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../../core/theme/theme.dart';
import '../../../classes/presentation/screens/my_classes_screen.dart';
import '../../../mentors/presentation/screens/mentor_hub_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MyClassesScreen(),
    const MentorHubScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows body to go behind the navbar
      body: _screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.7), // Glass overlay
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_outlined),
                  activeIcon: Icon(Icons.school),
                  label: 'Kelas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_search_outlined),
                  activeIcon: Icon(Icons.person_search),
                  label: 'Mentor',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent, // Transparent for Glass effect
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
