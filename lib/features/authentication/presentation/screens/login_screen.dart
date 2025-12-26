import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/theme.dart';
import '../../../main/presentation/screens/main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8ECF4)),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Title
              Text(
                "Welcome back! Glad\nto see you, Again!",
                style: GoogleFonts.urbanist(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E232C),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 40),

              // Email Field
              _buildTextField(hint: "Enter your email"),
              const SizedBox(height: 16),

              // Password Field
              _buildTextField(
                hint: "Enter your password",
                isPassword: true,
                isVisible: _isPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),

              const SizedBox(height: 12),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.urbanist(
                    color: const Color(0xFF6A707C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor, // Soft Purple
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    "Login",
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              // Or Login With Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE8ECF4), thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Or Login with",
                      style: GoogleFonts.urbanist(
                        color: const Color(0xFF6A707C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE8ECF4), thickness: 1)),
                ],
              ),

              const SizedBox(height: 30),
              // Social Buttons
              Row(
                children: [
                   Expanded(child: _buildSocialButton(icon: Icons.facebook, color: const Color(0xFF1877F2))),
                   const SizedBox(width: 16),
                   Expanded(
                     child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE8ECF4)),
                        color: Colors.white,
                      ),
                      child: Center(
                        // Using network image for Google
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                          height: 24,
                          loadingBuilder: (context, child, loadingProgress) {
                             if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                          },
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, size: 40),
                        ),
                      ),
                    ),
                   ),
                   const SizedBox(width: 16),
                   Expanded(child: _buildSocialButton(icon: Icons.apple, color: Colors.black)),
                ],
              ),

              const SizedBox(height: 50),
              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.urbanist(
                      color: const Color(0xFF1E232C),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Register Now",
                      style: GoogleFonts.urbanist(
                        color: kPrimaryColor, // Soft Purple
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onVisibilityToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE8ECF4)),
      ),
      child: TextField(
        obscureText: isPassword && !isVisible,
        style: GoogleFonts.urbanist(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.urbanist(color: const Color(0xFF8391A1)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF8391A1),
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSocialButton({IconData? icon, Color? color}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE8ECF4)),
        color: Colors.white,
      ),
      child: Center(
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
