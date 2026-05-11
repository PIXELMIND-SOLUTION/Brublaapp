import 'package:brublaapp/provider/dessigner/designer_provider.dart';
import 'package:brublaapp/provider/navbar/navbar_provider.dart';
import 'package:brublaapp/provider/navbar/tailor/tailor_navbar_provider.dart';
import 'package:brublaapp/provider/stylist/stylist_navbar_provider.dart';
import 'package:brublaapp/views/Stylistmodule/navbar/navbar_screen.dart';
import 'package:brublaapp/views/Tailormodule/navbar/navbar_screen.dart';
import 'package:brublaapp/views/navbar/auth/auth_provider.dart';
import 'package:brublaapp/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum AuthStep { requestOtp, verifyOtp, register, registerVerifyOtp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  AuthStep _currentStep = AuthStep.requestOtp;

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registerMobileController =
      TextEditingController();
  final TextEditingController _registerOtpController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ['Tailor', 'Designer', 'User', 'Stylist'];

  // Sheet entrance animation
  late AnimationController _sheetEntranceController;
  late Animation<double> _sheetSlideAnimation;
  late Animation<double> _sheetFadeAnimation;

  // Pulse animation for the Request OTP button
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  static const Color _tan = Color(0xFFCFB896);
  static const Color _black = Color(0xFF0A0A0A);
  static const Color _border = Color(0xFFE0E0E0);
  static const Color _hintGrey = Color(0xFFAAAAAA);
  static const Color _errorFill = Color(0xFFFFF0F0);

  @override
  void initState() {
    super.initState();

    _sheetEntranceController = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    _sheetSlideAnimation = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(
        parent: _sheetEntranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    _sheetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sheetEntranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _sheetEntranceController.forward();
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _registerMobileController.dispose();
    _registerOtpController.dispose();
    _sheetEntranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // ── Navigation after auth ─────────────────────────────────────────────────
  void _navigateByCategory(String? category) {
    if (category == null) {
      _showSnack('Please select a category');
      return;
    }

    Widget destination;
    switch (category) {
      case 'Tailor':
        destination = ChangeNotifierProvider(
          create: (_) => TailorNavbarProvider(),
          child: const TailorNavbarScreen(),
        );
        break;
      case 'Designer':
        destination = ChangeNotifierProvider(
          create: (_) => DesignerNavbarProvider(),
          child: const TailorNavbarScreen(),
        );
        break;
      case 'Stylist':
        destination = ChangeNotifierProvider(
          create: (_) => StylistNavbarProvider(),
          child: const StylistNavbarScreen(),
        );
        break;
      case 'User':
      default:
        destination = ChangeNotifierProvider(
          create: (_) => UserNavbarProvider(),
          child: NavbarScreen(),
        );
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ── Step 1: Request Login OTP ─────────────────────────────────────────────
  // Future<void> _handleRequestOtp() async {
  //   final mobile = _mobileController.text.trim();
  //   if (mobile.isEmpty || mobile.length < 10) {
  //     _showSnack('Enter a valid mobile number');
  //     return;
  //   }
  //   final auth = context.read<AuthProvider>();
  //   await auth.login(mobile);

  //   if (!mounted) return;

  //   if (auth.state == AuthState.otpSent) {
  //     // User already registered → go to OTP verify
  //     setState(() => _currentStep = AuthStep.verifyOtp);
  //   } else if (auth.state == AuthState.error) {
  //     // User not found → go to register
  //     // (Adjust this logic based on your API's actual error message)
  //     final err = auth.errorMessage ?? '';
  //     if (err.toLowerCase().contains('not found') ||
  //         err.toLowerCase().contains('not registered') ||
  //         err.toLowerCase().contains("doesn't exist")) {
  //       setState(() => _currentStep = AuthStep.register);
  //     } else {
  //       _showSnack(err);
  //     }
  //   }
  // }

  Future<void> _handleRequestOtp() async {
    final mobile = _mobileController.text.trim();
    if (mobile.isEmpty || mobile.length < 10) {
      _showSnack('Enter a valid mobile number');
      return;
    }
    final auth = context.read<AuthProvider>();
    await auth.login(mobile);

    if (!mounted) return;

    if (auth.state == AuthState.otpSent) {
      // Existing user → go to OTP verify
      setState(() => _currentStep = AuthStep.verifyOtp);
    } else if (auth.state == AuthState.error) {
      final err = auth.errorMessage ?? '';
      if (err.toLowerCase().contains('not found') ||
          err.toLowerCase().contains('not registered') ||
          err.toLowerCase().contains("doesn't exist")) {
        // ✅ Pre-fill the mobile number into the register form
        _registerMobileController.text = mobile;
        setState(() => _currentStep = AuthStep.register);
      } else {
        _showSnack(err);
      }
    }
  }

  // ── Step 2: Verify Login OTP ──────────────────────────────────────────────
  Future<void> _handleVerifyLoginOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || otp.length < 4) {
      _showSnack('Enter a valid OTP');
      return;
    }
    final auth = context.read<AuthProvider>();
    await auth.verifyLoginOtp(otp);

    if (!mounted) return;

    if (auth.state == AuthState.authenticated) {
      _navigateByCategory(auth.currentUser?.role);
    } else if (auth.state == AuthState.error) {
      _showSnack(auth.errorMessage ?? 'OTP verification failed');
    }
  }

  // ── Step 3: Send Register OTP ─────────────────────────────────────────────
  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final mobile = _registerMobileController.text.trim();
    final email = _emailController.text.trim();
    final category = _selectedCategory;

    if (name.isEmpty) {
      _showSnack('Enter your name');
      return;
    }
    if (mobile.isEmpty || mobile.length < 10) {
      _showSnack('Enter a valid mobile number');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      _showSnack('Enter a valid email');
      return;
    }
    if (category == null) {
      _showSnack('Please select a category');
      return;
    }

    final auth = context.read<AuthProvider>();
    await auth.register(
      name: name,
      mobile: mobile,
      email: email,
      role: category,
    );

    if (!mounted) return;

    if (auth.state == AuthState.otpSent) {
      // Move to register OTP verify step
      setState(() => _currentStep = AuthStep.registerVerifyOtp);
    } else if (auth.state == AuthState.error) {
      _showSnack(auth.errorMessage ?? 'Registration failed');
    }
  }

  // ── Step 4: Verify Register OTP → navigate ────────────────────────────────
  Future<void> _handleVerifyRegisterOtp() async {
    final otp = _registerOtpController.text.trim();
    if (otp.isEmpty || otp.length < 4) {
      _showSnack('Enter a valid OTP');
      return;
    }
    final auth = context.read<AuthProvider>();
    await auth.verifyRegisterOtp(otp);

    if (!mounted) return;

    if (auth.state == AuthState.authenticated) {
      _navigateByCategory(_selectedCategory);
    } else if (auth.state == AuthState.error) {
      _showSnack(auth.errorMessage ?? 'OTP verification failed');
    }
  }

  // ── Resend OTP ────────────────────────────────────────────────────────────
  Future<void> _handleResendOtp() async {
    final auth = context.read<AuthProvider>();
    await auth.resendOtp();
    if (!mounted) return;
    if (auth.state == AuthState.otpSent) {
      _showSnack(auth.successMessage ?? 'OTP resent successfully');
    } else if (auth.state == AuthState.error) {
      _showSnack(auth.errorMessage ?? 'Failed to resend OTP');
    }
  }

  // ── UI helpers ────────────────────────────────────────────────────────────
  InputDecoration _inputDecoration(String hint, {bool isError = false}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: isError ? _tan : _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: isError ? _tan : _tan, width: 1.5),
      ),
      filled: true,
      fillColor: isError ? _errorFill : Colors.white,
    );
  }

  Widget _primaryButton(
    String label,
    VoidCallback? onTap, {
    bool isBlack = true,
  }) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) => Transform.scale(
        scale: isBlack ? _pulseAnimation.value : 1.0,
        child: child,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onTap,
          style:
              ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ).copyWith(
                overlayColor: WidgetStateProperty.all(
                  Colors.white.withOpacity(0.08),
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              if (isBlack) ...[
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingButton(String label) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dragHandle() => Center(
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

  Widget _iconHeader(IconData icon) => Center(
    child: Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: const Color(0xFFC8A96E), size: 24),
    ),
  );

  Widget _resendRow() => Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: _handleResendOtp,
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
  );

  Widget _buildRequestOtpSheet(AuthProvider auth) {
    final loading = auth.isLoading;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        _iconHeader(Icons.checkroom_rounded),
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
        const SizedBox(height: 6),
        const Center(
          child: Text(
            'Enter your mobile number to get started',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
        ),
        const SizedBox(height: 24),

        // TextField(
        //   controller: _mobileController,
        //   keyboardType: TextInputType.phone,
        //   decoration: _inputDecoration('Mobile Number'),
        // ),
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: _inputDecoration(
            'Mobile Number',
          ).copyWith(counterText: ''),
        ),
        const SizedBox(height: 16),
        loading
            ? _loadingButton('Requesting...')
            : _primaryButton('Request OTP', _handleRequestOtp),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _currentStep = AuthStep.register),
            child: const Text(
              "Dont have an account? Register here",
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Sheet: Step 2 — Verify Login OTP ─────────────────────────────────────
  Widget _buildVerifyOtpSheet(AuthProvider auth) {
    final loading = auth.isLoading;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        _iconHeader(Icons.lock_open_rounded),
        const Center(
          child: Text(
            'Verify OTP',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Center(
          child: Text(
            'Enter the code sent to your number',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
        ),
        const SizedBox(height: 24),

        // TextField(
        //   controller: _mobileController,
        //   keyboardType: TextInputType.phone,
        //   decoration: _inputDecoration('Mobile Number'),
        // ),
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: _inputDecoration(
            'Mobile Number',
          ).copyWith(counterText: ''),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: _inputDecoration('OTP').copyWith(counterText: ''),
        ),
        _resendRow(),
        const SizedBox(height: 12),
        loading
            ? _loadingButton('Verifying...')
            : _primaryButton('Verify', _handleVerifyLoginOtp),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () {
              context.read<AuthProvider>().reset();
              setState(() => _currentStep = AuthStep.requestOtp);
            },
            child: const Text(
              '← Back',
              style: TextStyle(color: Color(0xFF888888), fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  // ── Sheet: Step 3 — Register (fill details) ───────────────────────────────
  Widget _buildRegisterSheet(AuthProvider auth) {
    final loading = auth.isLoading;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        Center(
          child: Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_add_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
        const Center(
          child: Text(
            'Create Account',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Center(
          child: Text(
            'Fill in your details to register',
            style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: _inputDecoration('Name'),
        ),
        const SizedBox(height: 12),

        // TextField(
        //   controller: _registerMobileController,
        //   keyboardType: TextInputType.phone,
        //   decoration: _inputDecoration('Mobile Number'),
        // ),
        TextField(
          controller: _registerMobileController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: _inputDecoration(
            'Mobile Number',
          ).copyWith(counterText: ''),
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
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
          items: _categories
              .map(
                (c) => DropdownMenuItem(
                  value: c,
                  child: Text(c, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          onChanged: (val) => setState(() => _selectedCategory = val),
        ),
        const SizedBox(height: 20),
        loading
            ? _loadingButton('Sending OTP...')
            : _primaryButton('Register', _handleRegister, isBlack: false),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () {
              context.read<AuthProvider>().reset();
              setState(() => _currentStep = AuthStep.requestOtp);
            },
            child: const Text(
              'Already have an account? Login',
              style: TextStyle(color: Color(0xFF555555), fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  // ── Sheet: Step 4 — Verify Register OTP ──────────────────────────────────
  Widget _buildRegisterVerifyOtpSheet(AuthProvider auth) {
    final loading = auth.isLoading;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        _iconHeader(Icons.verified_user_rounded),
        const Center(
          child: Text(
            'Verify Your Number',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            'OTP sent to ${_registerMobileController.text.trim()}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
        ),
        const SizedBox(height: 24),

        // OTP boxes
        TextField(
          controller: _registerOtpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 10,
          ),
          decoration: _inputDecoration('— — — — — —').copyWith(
            counterText: '',
            hintStyle: const TextStyle(
              color: _hintGrey,
              fontSize: 22,
              letterSpacing: 10,
            ),
          ),
        ),

        _resendRow(),
        const SizedBox(height: 16),

        // Success message from provider
        if (auth.successMessage != null && !loading)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FFF4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF86EFAC)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xFF16A34A),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    auth.successMessage!,
                    style: const TextStyle(
                      color: Color(0xFF15803D),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

        loading
            ? _loadingButton('Verifying...')
            : _primaryButton('Confirm & Continue', _handleVerifyRegisterOtp),

        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () {
              context.read<AuthProvider>().reset();
              setState(() => _currentStep = AuthStep.register);
            },
            child: const Text(
              '← Edit Details',
              style: TextStyle(color: Color(0xFF888888), fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentSheetContent(AuthProvider auth) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: KeyedSubtree(
        key: ValueKey(_currentStep),
        child: switch (_currentStep) {
          AuthStep.requestOtp => _buildRequestOtpSheet(auth),
          AuthStep.verifyOtp => _buildVerifyOtpSheet(auth),
          AuthStep.register => _buildRegisterSheet(auth),
          AuthStep.registerVerifyOtp => _buildRegisterVerifyOtpSheet(auth),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/onboardingimage.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
              ),

              // Error banner (only when idle/error, not loading)
              if (auth.state == AuthState.error && auth.errorMessage != null)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  right: 16,
                  child: _ErrorBanner(
                    message: auth.errorMessage!,
                    onDismiss: () => auth.reset(),
                  ),
                ),

              // Animated bottom sheet
              AnimatedBuilder(
                animation: _sheetEntranceController,
                builder: (context, child) => AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  left: 0,
                  right: 0,
                  bottom: keyboardHeight,
                  child: Opacity(
                    opacity: _sheetFadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, _sheetSlideAnimation.value),
                      child: child,
                    ),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 28,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
                    child: _currentSheetContent(auth),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Reusable error banner ─────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ErrorBanner({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Color(0x33000000), blurRadius: 12),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFCFB896),
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white54,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
