import 'package:brublaapp/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';

enum AuthStep { requestOtp, verifyOtp, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthStep _currentStep = AuthStep.requestOtp;

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registerMobileController =
      TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ['Tailor', 'Designer', 'User', 'Stylist'];

  static const Color _tan = Color(0xFFCFB896);
  static const Color _border = Color(0xFFE0E0E0);
  static const Color _hintGrey = Color(0xFFAAAAAA);
  static const Color _errorFill = Color(0xFFFFF0F0);

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _registerMobileController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint, {bool isError = false}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: isError ? const Color(0xFFCFB896) : _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: isError ? const Color(0xFFCFB896) : _tan, width: 1.5),
      ),
      filled: true,
      fillColor: isError ? _errorFill : Colors.white,
    );
  }

  Widget _primaryButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _tan,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  // ── Step 1: Request OTP ──────────────────────────────────────────────────────
  Widget _buildRequestOtpSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        const Center(
          child: Text(
            'Happy Shopping',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('Mobile Number'),
        ),
        const SizedBox(height: 16),
        _primaryButton('Request OTP', () {
          setState(() => _currentStep = AuthStep.verifyOtp);
        }),
      ],
    );
  }

  // ── Step 2: Verify OTP ───────────────────────────────────────────────────────
  Widget _buildVerifyOtpSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        const Center(
          child: Text(
            'Happy Shopping',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('Mobile Number'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('OTP'),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Resend OTP',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _primaryButton('Verify', () {
          setState(() => _currentStep = AuthStep.register);
        }),
      ],
    );
  }

  // ── Step 3: Register ─────────────────────────────────────────────────────────
  Widget _buildRegisterSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        const Center(
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: _inputDecoration('Name'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _registerMobileController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('Mobile Number'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('Email'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          hint: const Text(
            'Category',
            style: TextStyle(color: _hintGrey, fontSize: 14),
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _tan, width: 1.5),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _hintGrey),
          items: _categories.map((c) {
            return DropdownMenuItem(
              value: c,
              child: Text(c, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedCategory = val),
        ),
        const SizedBox(height: 20),
        _primaryButton('Verify', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavbarScreen()));
        }),
      ],
    );
  }

  Widget _currentSheetContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: KeyedSubtree(
        key: ValueKey(_currentStep),
        child: switch (_currentStep) {
          AuthStep.requestOtp => _buildRequestOtpSheet(),
          AuthStep.verifyOtp => _buildVerifyOtpSheet(),
          AuthStep.register => _buildRegisterSheet(),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ── KEY FIX: Read keyboard height from viewInsets ──────────────────────────
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      // Keep false so the background image never resizes/jumps
      resizeToAvoidBottomInset: false,
      // backgroundColor: const Color(0xFFF5F2EE),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),

      body: Stack(
        children: [
          // ── Background image – always full screen, never moves ─────────────
          Positioned.fill(
            child: Image.asset(
              'assets/onboardingimage.png',
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),

          // ── Bottom sheet panel – rises with the keyboard ───────────────────
          AnimatedPositioned(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            // Push the sheet up by exactly the keyboard height
            bottom: keyboardHeight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 20,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: _currentSheetContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}