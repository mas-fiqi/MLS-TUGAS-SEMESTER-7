import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/theme.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HTML: h-[45vh]
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.45;

    return Scaffold(
      backgroundColor: Colors.white, // bg-background-light
      body: Column(
        children: [
          // Top Image Section
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCGEgYsAPZAmze8g2IVPfzErp8iBCnhcM9ICkbJaS5cEtlQugcnzgAL-LKK-X3le6PFReYETMdMtKImFo4X4m_PpQArb2BQInTrKm8NwMSbnYSciV4Wiylw4LcNICEUqa14E-hX7ac50uXV3ClHWF71GYBXnM40pvhE-sLylDlEzfiefCW8c0yeuAFJ1AvS2x-7_2THSgbAN4-VqcTSmGH4exJYYBhzVLjwziGMcAX0vEZ_0KxQ85E0C38A4_Jva0LTIojTq80mVdI',
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.center, // object-center
                    ),
                  ),
                ),
                // Gradient Overlay
                // bg-gradient-to-b from-transparent to-background-light opacity-20
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.2), // opacity-20
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Content Section
          // flex-1 flex flex-col items-center justify-start px-8 pt-8 pb-12
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 32, // px-8
                right: 32, // px-8
                top: 32, // pt-8
                bottom: 48, // pb-12
              ),
              child: Column(
                children: [
                  // Logo Section (mb-12)
                  const SizedBox(height: 0), // Already have padding top, but flex-col items-center
                  
                  // Logo Circle
                  // w-20 h-20 rounded-full border-4 border-primary bg-white shadow-sm
                  Container(
                    width: 80, // w-20 (20 * 4 = 80px)
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 16), // mb-4
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: kPrimaryColor, // primary (was 0xFF0EA5E9, now purple)
                        width: 4, // border-4
                      ),
                      boxShadow: [
                         BoxShadow(
                          color: Colors.black.withOpacity(0.05), // shadow-sm (approx)
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.fingerprint, // SVG path d="..."
                      size: 48, // w-12 h-12 (12 * 4 = 48px)
                      color: kPrimaryColor,
                    ),
                  ),
                  
                  // App Name
                  // text-3xl font-bold tracking-tight text-gray-900
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.outfit(
                        fontSize: 30, // text-3xl ~ 30px
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827), // text-gray-900
                        letterSpacing: -0.025, // tracking-tight
                      ),
                      children: [
                        const TextSpan(text: "Fruzz"),
                        TextSpan(
                          text: "digital",
                          style: GoogleFonts.outfit(fontWeight: FontWeight.normal), // span font-normal
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(), // mt-auto
                  
                  // Buttons Container (space-y-4)
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 60, // py-4 (1rem top/bottom + text height) ~ 56-60px
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor, // bg-dark-button -> Primary Purple
                        foregroundColor: Colors.white,
                        elevation: 10, // shadow-lg
                        shadowColor: Colors.black.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // rounded-xl (12px-16px usually, user said xl=1rem=16px)
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // py-4 px-6
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.outfit(
                          fontSize: 18, // text-lg
                          fontWeight: FontWeight.w500, // font-medium
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16), // space-y-4
                  
                  // Register Button
                  // border-2 border-gray-900 text-gray-900
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryColor, // text-gray-900 -> Primary Purple
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(
                          color: kPrimaryColor, // border-gray-900 -> Primary Purple
                          width: 2, // border-2
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // rounded-xl
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                      child: Text(
                        "Register",
                        style: GoogleFonts.outfit(
                          fontSize: 18, // text-lg
                          fontWeight: FontWeight.w500, // font-medium
                        ),
                      ),
                    ),
                  ),

                  
                  const SizedBox(height: 16), // pt-4 (approx)
                  
                  // Guest Link
                  GestureDetector(
                    onTap: () {
                      // Navigate to guest/home
                    },
                    child: Text(
                      "Continue as a guest",
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF0EA5E9), // text-primary
                        fontSize: 16, // text-base
                        fontWeight: FontWeight.w500, // font-medium
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF0EA5E9), // decoration-primary
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
