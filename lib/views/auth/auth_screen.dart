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
  final List<String> _categories = [
    'Male',
    'Female',
    'Kids',
    'Unisex',
  ];

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _registerMobileController.dispose();
    super.dispose();
  }

  // ── shared colours ──────────────────────────────────────────────────────────
  static const Color _tan = Color(0xFFCFB896);
  static const Color _border = Color(0xFFE0E0E0);
  static const Color _hintGrey = Color(0xFFAAAAAA);
  static const Color _labelGrey = Color(0xFF555555);

  // ── helpers ─────────────────────────────────────────────────────────────────

  Widget _buildPhoneImage() {
    return Center(
      child: SizedBox(
        height: 260,
        child: Image.asset(
          'assets/onboardingimage.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint,
      {bool isError = false, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: isError ? const Color(0xFFE57373) : _border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: isError ? const Color(0xFFE57373) : _tan,
          width: 1.5,
        ),
      ),
      filled: isError,
      fillColor: isError ? const Color(0xFFFFF3F3) : null,
      suffixIcon: suffix,
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
            borderRadius: BorderRadius.circular(8),
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

  // ── Step 1: Request OTP ──────────────────────────────────────────────────────
  Widget _buildRequestOtp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPhoneImage(),
        const SizedBox(height: 28),
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
        const SizedBox(height: 24),
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration('Mobile Number'),
        ),
        const SizedBox(height: 20),
        _primaryButton('Request OTP', () {
          setState(() => _currentStep = AuthStep.verifyOtp);
        }),
      ],
    );
  }

  // ── Step 2: Verify OTP ───────────────────────────────────────────────────────
  Widget _buildVerifyOtp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPhoneImage(),
        const SizedBox(height: 28),
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
        const SizedBox(height: 24),
        // Pre-filled mobile (shown with error-style pink bg as in screenshot)
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration(
            'Mobile Number',
            isError: true,
          ),
        ),
        const SizedBox(height: 12),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('OTP'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  // resend OTP logic
                },
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: _labelGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _primaryButton('Verify', () {
          setState(() => _currentStep = AuthStep.register);
        }),
      ],
    );
  }

  // ── Step 3: Register ─────────────────────────────────────────────────────────
  Widget _buildRegister() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPhoneImage(),
        const SizedBox(height: 28),
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
        const SizedBox(height: 24),
        // Name – error state as in screenshot
        TextField(
          controller: _nameController,
          decoration: _inputDecoration('Name', isError: true),
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
        // Category dropdown
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          hint: const Text(
            'Category',
            style: TextStyle(color: _hintGrey, fontSize: 14),
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: _border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
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
          // handle registration submit
        }),
      ],
    );
  }

  // ── build ────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: KeyedSubtree(
              key: ValueKey(_currentStep),
              child: switch (_currentStep) {
                AuthStep.requestOtp => _buildRequestOtp(),
                AuthStep.verifyOtp => _buildVerifyOtp(),
                AuthStep.register => _buildRegister(),
              },
            ),
          ),
        ),
      ),
    );
  }
}