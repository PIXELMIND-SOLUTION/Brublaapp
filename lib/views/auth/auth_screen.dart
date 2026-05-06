// // // import 'package:android_intent_plus/android_intent.dart';
// // // import 'package:android_intent_plus/flag.dart';
// // // import 'package:brublaapp/views/navbar/navbar_screen.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:url_launcher/url_launcher.dart';

// // // enum AuthStep { requestOtp, verifyOtp, register }

// // // class AuthScreen extends StatefulWidget {
// // //   const AuthScreen({super.key});

// // //   @override
// // //   State<AuthScreen> createState() => _AuthScreenState();
// // // }

// // // class _AuthScreenState extends State<AuthScreen> {
// // //   AuthStep _currentStep = AuthStep.requestOtp;

// // //   final TextEditingController _mobileController = TextEditingController();
// // //   final TextEditingController _otpController = TextEditingController();
// // //   final TextEditingController _nameController = TextEditingController();
// // //   final TextEditingController _emailController = TextEditingController();
// // //   final TextEditingController _registerMobileController =
// // //       TextEditingController();

// // //   String? _selectedCategory;
// // //   final List<String> _categories = ['Tailor', 'Designer', 'User', 'Stylist'];

// // //   static const Color _tan = Color(0xFFCFB896);
// // //   static const Color _border = Color(0xFFE0E0E0);
// // //   static const Color _hintGrey = Color(0xFFAAAAAA);
// // //   static const Color _errorFill = Color(0xFFFFF0F0);

// // //   @override
// // //   void dispose() {
// // //     _mobileController.dispose();
// // //     _otpController.dispose();
// // //     _nameController.dispose();
// // //     _emailController.dispose();
// // //     _registerMobileController.dispose();
// // //     super.dispose();
// // //   }

// // // //   Future<void> _launchCategoryApp(String? category) async {
// // // //   if (category == 'Tailor') {
// // // //     final uri = Uri.parse('brubla-tailor://');

// // // //     if (await canLaunchUrl(uri)) {
// // // //       await launchUrl(uri);
// // // //     } else {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         const SnackBar(content: Text('Tailor app is not installed')),
// // // //       );
// // // //     }
// // // //   } else {
// // // //     // For other categories, go to NavbarScreen as before
// // // //     Navigator.push(
// // // //       context,
// // // //       MaterialPageRoute(builder: (_) => NavbarScreen()),
// // // //     );
// // // //   }
// // // // }

// // // // Future<void> _launchCategoryApp(String? category) async {
// // // //   if (category == 'Tailor') {
// // // //     try {
// // // //       final intent = AndroidIntent(
// // // //         action: 'android.intent.action.MAIN',
// // // //         package: 'com.example.brubla_tailor',  // exact package name
// // // //         componentName: 'com.example.brubla_tailor.MainActivity',
// // // //         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
// // // //       );
// // // //       await intent.launch();
// // // //     } catch (e) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Could not open Tailor app: $e')),
// // // //       );
// // // //     }
// // // //   } else {
// // // //     Navigator.push(
// // // //       context,
// // // //       MaterialPageRoute(builder: (_) => NavbarScreen()),
// // // //     );
// // // //   }
// // // // }

// // // Future<void> _launchCategoryApp(String? category) async {
// // //   if (category == 'Tailor') {
// // //     try {
// // //       final intent = AndroidIntent(
// // //         action: 'android.intent.action.MAIN',
// // //         package: 'com.example.brubla_tailor',
// // //         componentName: 'com.example.brubla_tailor.MainActivity',
// // //         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
// // //       );
// // //       await intent.launch();
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Could not open Tailor app: $e')),
// // //       );
// // //     }
// // //   } else if (category == 'Stylist') {
// // //     try {
// // //       final intent = AndroidIntent(
// // //         action: 'android.intent.action.MAIN',
// // //         package: 'com.example.brubla_stylist',
// // //         componentName: 'com.example.brubla_stylist.MainActivity',
// // //         flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
// // //       );
// // //       await intent.launch();
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('Could not open Stylist app: $e')),
// // //       );
// // //     }
// // //   } else {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(builder: (_) => NavbarScreen()),
// // //     );
// // //   }
// // // }

// // //   InputDecoration _inputDecoration(String hint, {bool isError = false}) {
// // //     return InputDecoration(
// // //       hintText: hint,
// // //       hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
// // //       contentPadding:
// // //           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // //       enabledBorder: OutlineInputBorder(
// // //         borderRadius: BorderRadius.circular(8),
// // //         borderSide:
// // //             BorderSide(color: isError ? const Color(0xFFCFB896) : _border),
// // //       ),
// // //       focusedBorder: OutlineInputBorder(
// // //         borderRadius: BorderRadius.circular(8),
// // //         borderSide: BorderSide(
// // //             color: isError ? const Color(0xFFCFB896) : _tan, width: 1.5),
// // //       ),
// // //       filled: true,
// // //       fillColor: isError ? _errorFill : Colors.white,
// // //     );
// // //   }

// // //   Widget _primaryButton(String label, VoidCallback onTap) {
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       height: 52,
// // //       child: ElevatedButton(
// // //         onPressed: onTap,
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: _tan,
// // //           foregroundColor: Colors.white,
// // //           elevation: 0,
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(10),
// // //           ),
// // //         ),
// // //         child: Text(
// // //           label,
// // //           style: const TextStyle(
// // //             fontSize: 16,
// // //             fontWeight: FontWeight.w600,
// // //             letterSpacing: 0.3,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _dragHandle() {
// // //     return Center(
// // //       child: Container(
// // //         width: 40,
// // //         height: 4,
// // //         margin: const EdgeInsets.only(bottom: 20),
// // //         decoration: BoxDecoration(
// // //           color: Colors.grey[300],
// // //           borderRadius: BorderRadius.circular(2),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // ── Step 1: Request OTP ──────────────────────────────────────────────────────
// // //   Widget _buildRequestOtpSheet() {
// // //     return Column(
// // //       mainAxisSize: MainAxisSize.min,
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         _dragHandle(),
// // //         const Center(
// // //           child: Text(
// // //             'Happy Shopping',
// // //             style: TextStyle(
// // //               fontSize: 22,
// // //               fontWeight: FontWeight.w700,
// // //               color: Color(0xFF1A1A1A),
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 20),
// // //         TextField(
// // //           controller: _mobileController,
// // //           keyboardType: TextInputType.phone,
// // //           decoration: _inputDecoration('Mobile Number'),
// // //         ),
// // //         const SizedBox(height: 16),
// // //         _primaryButton('Request OTP', () {
// // //           setState(() => _currentStep = AuthStep.verifyOtp);
// // //         }),
// // //       ],
// // //     );
// // //   }

// // //   // ── Step 2: Verify OTP ───────────────────────────────────────────────────────
// // //   Widget _buildVerifyOtpSheet() {
// // //     return Column(
// // //       mainAxisSize: MainAxisSize.min,
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         _dragHandle(),
// // //         const Center(
// // //           child: Text(
// // //             'Happy Shopping',
// // //             style: TextStyle(
// // //               fontSize: 22,
// // //               fontWeight: FontWeight.w700,
// // //               color: Color(0xFF1A1A1A),
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 20),
// // //         TextField(
// // //           controller: _mobileController,
// // //           keyboardType: TextInputType.phone,
// // //           decoration: _inputDecoration('Mobile Number'),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           controller: _otpController,
// // //           keyboardType: TextInputType.number,
// // //           decoration: _inputDecoration('OTP'),
// // //         ),
// // //         Align(
// // //           alignment: Alignment.centerRight,
// // //           child: TextButton(
// // //             onPressed: () {},
// // //             style: TextButton.styleFrom(
// // //               padding: EdgeInsets.zero,
// // //               minimumSize: Size.zero,
// // //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// // //             ),
// // //             child: const Text(
// // //               'Resend OTP',
// // //               style: TextStyle(
// // //                 color: Color(0xFF555555),
// // //                 fontSize: 13,
// // //                 fontWeight: FontWeight.w500,
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         _primaryButton('Verify', () {
// // //           setState(() => _currentStep = AuthStep.register);
// // //         }),
// // //       ],
// // //     );
// // //   }

// // //   // ── Step 3: Register ─────────────────────────────────────────────────────────
// // //   Widget _buildRegisterSheet() {
// // //     return Column(
// // //       mainAxisSize: MainAxisSize.min,
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         _dragHandle(),
// // //         const Center(
// // //           child: Text(
// // //             'Register',
// // //             style: TextStyle(
// // //               fontSize: 22,
// // //               fontWeight: FontWeight.w700,
// // //               color: Color(0xFF1A1A1A),
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 20),
// // //         TextField(
// // //           controller: _nameController,
// // //           decoration: _inputDecoration('Name'),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           controller: _registerMobileController,
// // //           keyboardType: TextInputType.phone,
// // //           decoration: _inputDecoration('Mobile Number'),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           controller: _emailController,
// // //           keyboardType: TextInputType.emailAddress,
// // //           decoration: _inputDecoration('Email'),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         DropdownButtonFormField<String>(
// // //           value: _selectedCategory,
// // //           hint: const Text(
// // //             'Category',
// // //             style: TextStyle(color: _hintGrey, fontSize: 14),
// // //           ),
// // //           decoration: InputDecoration(
// // //             contentPadding:
// // //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // //             filled: true,
// // //             fillColor: Colors.white,
// // //             enabledBorder: OutlineInputBorder(
// // //               borderRadius: BorderRadius.circular(8),
// // //               borderSide: const BorderSide(color: _border),
// // //             ),
// // //             focusedBorder: OutlineInputBorder(
// // //               borderRadius: BorderRadius.circular(8),
// // //               borderSide: const BorderSide(color: _tan, width: 1.5),
// // //             ),
// // //           ),
// // //           icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _hintGrey),
// // //           items: _categories.map((c) {
// // //             return DropdownMenuItem(
// // //               value: c,
// // //               child: Text(c, style: const TextStyle(fontSize: 14)),
// // //             );
// // //           }).toList(),
// // //           onChanged: (val) => setState(() => _selectedCategory = val),
// // //         ),
// // //         const SizedBox(height: 20),

// // //         _primaryButton('Verify', () {
// // //   _launchCategoryApp(_selectedCategory);
// // // }),
// // //         // _primaryButton('Verify', () {
// // //         //   Navigator.push(
// // //         //       context,
// // //         //       MaterialPageRoute(
// // //         //           builder: (context) => NavbarScreen()));
// // //         // }),
// // //       ],
// // //     );
// // //   }

// // //   Widget _currentSheetContent() {
// // //     return AnimatedSwitcher(
// // //       duration: const Duration(milliseconds: 250),
// // //       transitionBuilder: (child, animation) =>
// // //           FadeTransition(opacity: animation, child: child),
// // //       child: KeyedSubtree(
// // //         key: ValueKey(_currentStep),
// // //         child: switch (_currentStep) {
// // //           AuthStep.requestOtp => _buildRequestOtpSheet(),
// // //           AuthStep.verifyOtp => _buildVerifyOtpSheet(),
// // //           AuthStep.register => _buildRegisterSheet(),
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // ── KEY FIX: Read keyboard height from viewInsets ──────────────────────────
// // //     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

// // //     return Scaffold(
// // //       // Keep false so the background image never resizes/jumps
// // //       resizeToAvoidBottomInset: false,
// // //       // backgroundColor: const Color(0xFFF5F2EE),
// // //             backgroundColor: const Color.fromARGB(255, 0, 0, 0),

// // //       body: Stack(
// // //         children: [
// // //           // ── Background image – always full screen, never moves ─────────────
// // //           Positioned.fill(
// // //             child: Image.asset(
// // //               'assets/onboardingimage.png',
// // //               fit: BoxFit.contain,
// // //               alignment: Alignment.topCenter,
// // //             ),
// // //           ),

// // //           // ── Bottom sheet panel – rises with the keyboard ───────────────────
// // //           AnimatedPositioned(
// // //             duration: const Duration(milliseconds: 150),
// // //             curve: Curves.easeOut,
// // //             left: 0,
// // //             right: 0,
// // //             // Push the sheet up by exactly the keyboard height
// // //             bottom: keyboardHeight,
// // //             child: Material(
// // //               color: Colors.transparent,
// // //               child: Container(
// // //                 decoration: const BoxDecoration(
// // //                   color: Colors.white,
// // //                   borderRadius:
// // //                       BorderRadius.vertical(top: Radius.circular(24)),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Color(0x18000000),
// // //                       blurRadius: 20,
// // //                       offset: Offset(0, -4),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
// // //                 child: _currentSheetContent(),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:brublaapp/views/Stylistmodule/navbar/navbar_screen.dart';
// // import 'package:brublaapp/views/Tailormodule/navbar/navbar_screen.dart';
// // import 'package:brublaapp/views/navbar/navbar_screen.dart';

// // import 'package:flutter/material.dart';

// // enum AuthStep { requestOtp, verifyOtp, register }

// // class AuthScreen extends StatefulWidget {
// //   const AuthScreen({super.key});

// //   @override
// //   State<AuthScreen> createState() => _AuthScreenState();
// // }

// // class _AuthScreenState extends State<AuthScreen> {
// //   AuthStep _currentStep = AuthStep.requestOtp;

// //   final TextEditingController _mobileController = TextEditingController();
// //   final TextEditingController _otpController = TextEditingController();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _registerMobileController =
// //       TextEditingController();

// //   String? _selectedCategory;
// //   final List<String> _categories = ['Tailor', 'Designer', 'User', 'Stylist'];

// //   static const Color _tan = Color(0xFFCFB896);
// //   static const Color _border = Color(0xFFE0E0E0);
// //   static const Color _hintGrey = Color(0xFFAAAAAA);
// //   static const Color _errorFill = Color(0xFFFFF0F0);

// //   @override
// //   void dispose() {
// //     _mobileController.dispose();
// //     _otpController.dispose();
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _registerMobileController.dispose();
// //     super.dispose();
// //   }

// //   // ✅ ONLY THIS METHOD CHANGED — no AndroidIntent, no separate apps
// //   void _navigateByCategory(String? category) {
// //     if (category == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please select a category')),
// //       );
// //       return;
// //     }

// //     Widget destination;

// //     switch (category) {
// //       case 'Tailor':
// //         destination = const TailorNavbarScreen();
// //         break;
// //       case 'Designer':
// //         destination = const StylistNavbarScreen();
// //         break;
// //       case 'Stylist':
// //         destination = const StylistNavbarScreen();
// //         break;
// //       case 'User':
// //       default:
// //         destination = NavbarScreen(); // your existing user navbar
// //         break;
// //     }

// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(builder: (_) => destination),
// //     );
// //   }

// //   InputDecoration _inputDecoration(String hint, {bool isError = false}) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
// //       contentPadding:
// //           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       enabledBorder: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(8),
// //         borderSide:
// //             BorderSide(color: isError ? const Color(0xFFCFB896) : _border),
// //       ),
// //       focusedBorder: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(8),
// //         borderSide: BorderSide(
// //             color: isError ? const Color(0xFFCFB896) : _tan, width: 1.5),
// //       ),
// //       filled: true,
// //       fillColor: isError ? _errorFill : Colors.white,
// //     );
// //   }

// //   Widget _primaryButton(String label, VoidCallback onTap) {
// //     return SizedBox(
// //       width: double.infinity,
// //       height: 52,
// //       child: ElevatedButton(
// //         onPressed: onTap,
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: _tan,
// //           foregroundColor: Colors.white,
// //           elevation: 0,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //         ),
// //         child: Text(
// //           label,
// //           style: const TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.w600,
// //             letterSpacing: 0.3,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _dragHandle() {
// //     return Center(
// //       child: Container(
// //         width: 40,
// //         height: 4,
// //         margin: const EdgeInsets.only(bottom: 20),
// //         decoration: BoxDecoration(
// //           color: Colors.grey[300],
// //           borderRadius: BorderRadius.circular(2),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildRequestOtpSheet() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _dragHandle(),
// //         const Center(
// //           child: Text(
// //             'Happy Shopping',
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.w700,
// //               color: Color(0xFF1A1A1A),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 20),
// //         TextField(
// //           controller: _mobileController,
// //           keyboardType: TextInputType.phone,
// //           decoration: _inputDecoration('Mobile Number'),
// //         ),
// //         const SizedBox(height: 16),
// //         _primaryButton('Request OTP', () {
// //           setState(() => _currentStep = AuthStep.verifyOtp);
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _buildVerifyOtpSheet() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _dragHandle(),
// //         const Center(
// //           child: Text(
// //             'Happy Shopping',
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.w700,
// //               color: Color(0xFF1A1A1A),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 20),
// //         TextField(
// //           controller: _mobileController,
// //           keyboardType: TextInputType.phone,
// //           decoration: _inputDecoration('Mobile Number'),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _otpController,
// //           keyboardType: TextInputType.number,
// //           decoration: _inputDecoration('OTP'),
// //         ),
// //         Align(
// //           alignment: Alignment.centerRight,
// //           child: TextButton(
// //             onPressed: () {},
// //             style: TextButton.styleFrom(
// //               padding: EdgeInsets.zero,
// //               minimumSize: Size.zero,
// //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //             ),
// //             child: const Text(
// //               'Resend OTP',
// //               style: TextStyle(
// //                 color: Color(0xFF555555),
// //                 fontSize: 13,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         _primaryButton('Verify', () {
// //           setState(() => _currentStep = AuthStep.register);
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _buildRegisterSheet() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         _dragHandle(),
// //         const Center(
// //           child: Text(
// //             'Register',
// //             style: TextStyle(
// //               fontSize: 22,
// //               fontWeight: FontWeight.w700,
// //               color: Color(0xFF1A1A1A),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 20),
// //         TextField(
// //           controller: _nameController,
// //           decoration: _inputDecoration('Name'),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _registerMobileController,
// //           keyboardType: TextInputType.phone,
// //           decoration: _inputDecoration('Mobile Number'),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _emailController,
// //           keyboardType: TextInputType.emailAddress,
// //           decoration: _inputDecoration('Email'),
// //         ),
// //         const SizedBox(height: 12),
// //         DropdownButtonFormField<String>(
// //           value: _selectedCategory,
// //           hint: const Text(
// //             'Category',
// //             style: TextStyle(color: _hintGrey, fontSize: 14),
// //           ),
// //           decoration: InputDecoration(
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //             filled: true,
// //             fillColor: Colors.white,
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(8),
// //               borderSide: const BorderSide(color: _border),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(8),
// //               borderSide: const BorderSide(color: _tan, width: 1.5),
// //             ),
// //           ),
// //           icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _hintGrey),
// //           items: _categories.map((c) {
// //             return DropdownMenuItem(
// //               value: c,
// //               child: Text(c, style: const TextStyle(fontSize: 14)),
// //             );
// //           }).toList(),
// //           onChanged: (val) => setState(() => _selectedCategory = val),
// //         ),
// //         const SizedBox(height: 20),

// //         // ✅ Now calls _navigateByCategory instead of _launchCategoryApp
// //         _primaryButton('Register', () {
// //           _navigateByCategory(_selectedCategory);
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _currentSheetContent() {
// //     return AnimatedSwitcher(
// //       duration: const Duration(milliseconds: 250),
// //       transitionBuilder: (child, animation) =>
// //           FadeTransition(opacity: animation, child: child),
// //       child: KeyedSubtree(
// //         key: ValueKey(_currentStep),
// //         child: switch (_currentStep) {
// //           AuthStep.requestOtp => _buildRequestOtpSheet(),
// //           AuthStep.verifyOtp => _buildVerifyOtpSheet(),
// //           AuthStep.register => _buildRegisterSheet(),
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
// //       body: Stack(
// //         children: [
// //           Positioned.fill(
// //             child: Image.asset(
// //               'assets/onboardingimage.png',
// //               fit: BoxFit.contain,
// //               alignment: Alignment.topCenter,
// //             ),
// //           ),
// //           AnimatedPositioned(
// //             duration: const Duration(milliseconds: 150),
// //             curve: Curves.easeOut,
// //             left: 0,
// //             right: 0,
// //             bottom: keyboardHeight,
// //             child: Material(
// //               color: Colors.transparent,
// //               child: Container(
// //                 decoration: const BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius:
// //                       BorderRadius.vertical(top: Radius.circular(24)),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Color(0x18000000),
// //                       blurRadius: 20,
// //                       offset: Offset(0, -4),
// //                     ),
// //                   ],
// //                 ),
// //                 padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
// //                 child: _currentSheetContent(),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:brublaapp/provider/dessigner/designer_provider.dart';
// import 'package:brublaapp/provider/navbar/navbar_provider.dart';
// import 'package:brublaapp/provider/navbar/tailor/tailor_navbar_provider.dart';
// import 'package:brublaapp/provider/stylist/stylist_navbar_provider.dart';
// import 'package:brublaapp/views/Stylistmodule/navbar/navbar_screen.dart';
// import 'package:brublaapp/views/Tailormodule/navbar/navbar_screen.dart';
// import 'package:brublaapp/views/navbar/navbar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// enum AuthStep { requestOtp, verifyOtp, register }

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   AuthStep _currentStep = AuthStep.requestOtp;

//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _registerMobileController =
//       TextEditingController();

//   String? _selectedCategory;
//   final List<String> _categories = ['Tailor', 'Designer', 'User', 'Stylist'];

//   static const Color _tan = Color(0xFFCFB896);
//   static const Color _border = Color(0xFFE0E0E0);
//   static const Color _hintGrey = Color(0xFFAAAAAA);
//   static const Color _errorFill = Color(0xFFFFF0F0);

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     _otpController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _registerMobileController.dispose();
//     super.dispose();
//   }

//   void _navigateByCategory(String? category) {
//     if (category == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a category')),
//       );
//       return;
//     }

//     Widget destination;

//     switch (category) {
//       case 'Tailor':
//         destination = ChangeNotifierProvider(
//           create: (_) => TailorNavbarProvider(),
//           child: const TailorNavbarScreen(),
//         );
//         break;
//       case 'Designer':
//         destination = ChangeNotifierProvider(
//           create: (_) => DesignerNavbarProvider(),
//           // child: const DesignerNavbarScreen(),
//                     child: const TailorNavbarScreen(),

//         );
//         break;
//       case 'Stylist':
//         destination = ChangeNotifierProvider(
//           create: (_) => StylistNavbarProvider(),
//           child: const StylistNavbarScreen(),
//         );
//         break;
//       case 'User':
//       default:
//         destination = ChangeNotifierProvider(
//           create: (_) => UserNavbarProvider(),
//           child: NavbarScreen(),
//         );
//         break;
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => destination),
//     );
//   }

//   InputDecoration _inputDecoration(String hint, {bool isError = false}) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide:
//             BorderSide(color: isError ? const Color(0xFFCFB896) : _border),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(
//             color: isError ? const Color(0xFFCFB896) : _tan, width: 1.5),
//       ),
//       filled: true,
//       fillColor: isError ? _errorFill : Colors.white,
//     );
//   }

//   Widget _primaryButton(String label, VoidCallback onTap) {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _tan,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.3,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _dragHandle() {
//     return Center(
//       child: Container(
//         width: 40,
//         height: 4,
//         margin: const EdgeInsets.only(bottom: 20),
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(2),
//         ),
//       ),
//     );
//   }

//   Widget _buildRequestOtpSheet() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _dragHandle(),
//         const Center(
//           child: Text(
//             'Happy Shopping',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1A1A1A),
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           controller: _mobileController,
//           keyboardType: TextInputType.phone,
//           decoration: _inputDecoration('Mobile Number'),
//         ),
//         const SizedBox(height: 16),
//         _primaryButton('Request OTP', () {
//           setState(() => _currentStep = AuthStep.verifyOtp);
//         }),
//       ],
//     );
//   }

//   Widget _buildVerifyOtpSheet() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _dragHandle(),
//         const Center(
//           child: Text(
//             'Happy Shopping',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1A1A1A),
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           controller: _mobileController,
//           keyboardType: TextInputType.phone,
//           decoration: _inputDecoration('Mobile Number'),
//         ),
//         const SizedBox(height: 12),
//         TextField(
//           controller: _otpController,
//           keyboardType: TextInputType.number,
//           decoration: _inputDecoration('OTP'),
//         ),
//         Align(
//           alignment: Alignment.centerRight,
//           child: TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(
//               padding: EdgeInsets.zero,
//               minimumSize: Size.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             child: const Text(
//               'Resend OTP',
//               style: TextStyle(
//                 color: Color(0xFF555555),
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         _primaryButton('Verify', () {
//           setState(() => _currentStep = AuthStep.register);
//         }),
//       ],
//     );
//   }

//   Widget _buildRegisterSheet() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _dragHandle(),
//         const Center(
//           child: Text(
//             'Register',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1A1A1A),
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         TextField(
//           controller: _nameController,
//           decoration: _inputDecoration('Name'),
//         ),
//         const SizedBox(height: 12),
//         TextField(
//           controller: _registerMobileController,
//           keyboardType: TextInputType.phone,
//           decoration: _inputDecoration('Mobile Number'),
//         ),
//         const SizedBox(height: 12),
//         TextField(
//           controller: _emailController,
//           keyboardType: TextInputType.emailAddress,
//           decoration: _inputDecoration('Email'),
//         ),
//         const SizedBox(height: 12),
//         DropdownButtonFormField<String>(
//           value: _selectedCategory,
//           hint: const Text(
//             'Category',
//             style: TextStyle(color: _hintGrey, fontSize: 14),
//           ),
//           decoration: InputDecoration(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             filled: true,
//             fillColor: Colors.white,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: _border),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: _tan, width: 1.5),
//             ),
//           ),
//           icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _hintGrey),
//           items: _categories.map((c) {
//             return DropdownMenuItem(
//               value: c,
//               child: Text(c, style: const TextStyle(fontSize: 14)),
//             );
//           }).toList(),
//           onChanged: (val) => setState(() => _selectedCategory = val),
//         ),
//         const SizedBox(height: 20),
//         _primaryButton('Register', () {
//           _navigateByCategory(_selectedCategory);
//         }),
//       ],
//     );
//   }

//   Widget _currentSheetContent() {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 250),
//       transitionBuilder: (child, animation) =>
//           FadeTransition(opacity: animation, child: child),
//       child: KeyedSubtree(
//         key: ValueKey(_currentStep),
//         child: switch (_currentStep) {
//           AuthStep.requestOtp => _buildRequestOtpSheet(),
//           AuthStep.verifyOtp => _buildVerifyOtpSheet(),
//           AuthStep.register => _buildRegisterSheet(),
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/onboardingimage.png',
//               fit: BoxFit.contain,
//               alignment: Alignment.topCenter,
//             ),
//           ),
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 150),
//             curve: Curves.easeOut,
//             left: 0,
//             right: 0,
//             bottom: keyboardHeight,
//             child: Material(
//               color: Colors.transparent,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(24)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0x18000000),
//                       blurRadius: 20,
//                       offset: Offset(0, -4),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
//                 child: _currentSheetContent(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:brublaapp/provider/dessigner/designer_provider.dart';
// // import 'package:brublaapp/provider/navbar/navbar_provider.dart';
// // import 'package:brublaapp/provider/navbar/tailor/tailor_navbar_provider.dart';
// // import 'package:brublaapp/provider/stylist/stylist_navbar_provider.dart';
// // import 'package:brublaapp/views/Stylistmodule/navbar/navbar_screen.dart';
// // import 'package:brublaapp/views/Tailormodule/navbar/navbar_screen.dart';
// // import 'package:brublaapp/views/navbar/navbar_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // enum AuthStep { requestOtp, verifyOtp, register }

// // class AuthScreen extends StatefulWidget {
// //   const AuthScreen({super.key});

// //   @override
// //   State<AuthScreen> createState() => _AuthScreenState();
// // }

// // class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
// //   AuthStep _currentStep = AuthStep.requestOtp;

// //   final TextEditingController _mobileController = TextEditingController();
// //   final TextEditingController _otpController = TextEditingController();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _registerMobileController =
// //       TextEditingController();

// //   String? _selectedCategory;
// //   final List<String> _categories = ['Tailor', 'Designer', 'User', 'Stylist'];

// //   static const Color _black = Color(0xFF0A0A0A);
// //   static const Color _tan = Color(0xFFCFB896);
// //   static const Color _border = Color(0xFFEEEEEE);
// //   static const Color _hintGrey = Color(0xFFAAAAAA);
// //   static const Color _bg = Color(0xFFF9F7F4);

// //   @override
// //   void dispose() {
// //     _mobileController.dispose();
// //     _otpController.dispose();
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _registerMobileController.dispose();
// //     super.dispose();
// //   }

// //   void _navigateByCategory(String? category) {
// //     if (category == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please select a category')),
// //       );
// //       return;
// //     }

// //     Widget destination;

// //     switch (category) {
// //       case 'Tailor':
// //         destination = ChangeNotifierProvider(
// //           create: (_) => TailorNavbarProvider(),
// //           child: const TailorNavbarScreen(),
// //         );
// //         break;
// //       case 'Designer':
// //         destination = ChangeNotifierProvider(
// //           create: (_) => DesignerNavbarProvider(),
// //           child: const TailorNavbarScreen(),
// //         );
// //         break;
// //       case 'Stylist':
// //         destination = ChangeNotifierProvider(
// //           create: (_) => StylistNavbarProvider(),
// //           child: const StylistNavbarScreen(),
// //         );
// //         break;
// //       case 'User':
// //       default:
// //         destination = ChangeNotifierProvider(
// //           create: (_) => UserNavbarProvider(),
// //           child: NavbarScreen(),
// //         );
// //         break;
// //     }

// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(builder: (_) => destination),
// //     );
// //   }

// //   InputDecoration _inputDecoration(String hint, {IconData? icon}) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
// //       prefixIcon: icon != null
// //           ? Icon(icon, color: _hintGrey, size: 20)
// //           : null,
// //       contentPadding:
// //           const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// //       enabledBorder: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(12),
// //         borderSide: const BorderSide(color: _border),
// //       ),
// //       focusedBorder: OutlineInputBorder(
// //         borderRadius: BorderRadius.circular(12),
// //         borderSide: const BorderSide(color: _black, width: 1.5),
// //       ),
// //       filled: true,
// //       fillColor: Colors.white,
// //     );
// //   }

// //   Widget _primaryButton(String label, VoidCallback onTap) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: double.infinity,
// //         height: 54,
// //         decoration: BoxDecoration(
// //           color: _black,
// //           borderRadius: BorderRadius.circular(14),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.25),
// //               blurRadius: 16,
// //               offset: const Offset(0, 6),
// //             ),
// //           ],
// //         ),
// //         child: Center(
// //           child: Text(
// //             label,
// //             style: const TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.w700,
// //               color: Colors.white,
// //               letterSpacing: 0.3,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _dragHandle() {
// //     return Center(
// //       child: Container(
// //         width: 40,
// //         height: 4,
// //         margin: const EdgeInsets.only(bottom: 24),
// //         decoration: BoxDecoration(
// //           color: Colors.grey[300],
// //           borderRadius: BorderRadius.circular(2),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _sheetHeader(String title, {String? subtitle}) {
// //     return Column(
// //       children: [
// //         // Brand badge
// //         Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
// //           margin: const EdgeInsets.only(bottom: 14),
// //           decoration: BoxDecoration(
// //             color: const Color(0xFFF5F0EA),
// //             borderRadius: BorderRadius.circular(20),
// //           ),
// //           child: const Text(
// //             '✦  BRUBLA',
// //             style: TextStyle(
// //               fontSize: 11,
// //               fontWeight: FontWeight.w700,
// //               color: Color(0xFFB8966E),
// //               letterSpacing: 2.5,
// //             ),
// //           ),
// //         ),
// //         Text(
// //           title,
// //           style: const TextStyle(
// //             fontSize: 24,
// //             fontWeight: FontWeight.w800,
// //             color: Color(0xFF0A0A0A),
// //             letterSpacing: -0.5,
// //           ),
// //         ),
// //         if (subtitle != null) ...[
// //           const SizedBox(height: 6),
// //           Text(
// //             subtitle,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 13.5,
// //               color: Color(0xFF888888),
// //             ),
// //           ),
// //         ],
// //         const SizedBox(height: 28),
// //       ],
// //     );
// //   }

// //   Widget _buildRequestOtpSheet() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         _dragHandle(),
// //         _sheetHeader('Happy Shopping',
// //             subtitle: 'Enter your number to get started'),

// //         // Phone field with flag prefix
// //         Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: _border),
// //           ),
// //           child: Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.symmetric(
// //                     horizontal: 14, vertical: 16),
// //                 decoration: const BoxDecoration(
// //                   border:
// //                       Border(right: BorderSide(color: Color(0xFFEEEEEE))),
// //                 ),
// //                 child: const Text(
// //                   '🇮🇳  +91',
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: Color(0xFF333333),
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: TextField(
// //                   controller: _mobileController,
// //                   keyboardType: TextInputType.phone,
// //                   style: const TextStyle(
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.w500,
// //                     color: Color(0xFF111111),
// //                   ),
// //                   decoration: const InputDecoration(
// //                     hintText: 'Mobile Number',
// //                     hintStyle:
// //                         TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
// //                     contentPadding: EdgeInsets.symmetric(
// //                         horizontal: 14, vertical: 16),
// //                     border: InputBorder.none,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),

// //         const SizedBox(height: 20),
// //         _primaryButton('Request OTP', () {
// //           setState(() => _currentStep = AuthStep.verifyOtp);
// //         }),
// //         const SizedBox(height: 16),
// //         const Text(
// //           'By continuing, you agree to our Terms & Privacy Policy',
// //           textAlign: TextAlign.center,
// //           style: TextStyle(fontSize: 11.5, color: Color(0xFFAAAAAA), height: 1.5),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildVerifyOtpSheet() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         _dragHandle(),
// //         _sheetHeader('Verify OTP',
// //             subtitle: 'We sent a code to your mobile number'),

// //         // Phone field (read-only display)
// //         Container(
// //           decoration: BoxDecoration(
// //             color: const Color(0xFFF8F8F8),
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: _border),
// //           ),
// //           child: Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.symmetric(
// //                     horizontal: 14, vertical: 16),
// //                 decoration: const BoxDecoration(
// //                   border:
// //                       Border(right: BorderSide(color: Color(0xFFEEEEEE))),
// //                 ),
// //                 child: const Text(
// //                   '🇮🇳  +91',
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     fontWeight: FontWeight.w600,
// //                     color: Color(0xFF333333),
// //                   ),
// //                 ),
// //               ),
// //               Expanded(
// //                 child: TextField(
// //                   controller: _mobileController,
// //                   keyboardType: TextInputType.phone,
// //                   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
// //                   decoration: const InputDecoration(
// //                     hintText: 'Mobile Number',
// //                     hintStyle: TextStyle(color: _hintGrey, fontSize: 14),
// //                     contentPadding:
// //                         EdgeInsets.symmetric(horizontal: 14, vertical: 16),
// //                     border: InputBorder.none,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),

// //         const SizedBox(height: 12),

// //         // OTP boxes
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: List.generate(6, (i) {
// //             return Container(
// //               width: 46,
// //               height: 52,
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //                 border: Border.all(color: _border),
// //               ),
// //               child: Center(
// //                 child: TextField(
// //                   textAlign: TextAlign.center,
// //                   keyboardType: TextInputType.number,
// //                   maxLength: 1,
// //                   style: const TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.w700,
// //                     color: Color(0xFF0A0A0A),
// //                   ),
// //                   decoration: const InputDecoration(
// //                     counterText: '',
// //                     border: InputBorder.none,
// //                   ),
// //                 ),
// //               ),
// //             );
// //           }),
// //         ),

// //         Align(
// //           alignment: Alignment.centerRight,
// //           child: TextButton(
// //             onPressed: () {},
// //             style: TextButton.styleFrom(
// //               padding: const EdgeInsets.only(top: 4),
// //               minimumSize: Size.zero,
// //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //             ),
// //             child: const Text(
// //               'Resend OTP',
// //               style: TextStyle(
// //                 color: Color(0xFFCFB896),
// //                 fontSize: 13,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //         ),

// //         const SizedBox(height: 16),
// //         _primaryButton('Verify & Continue', () {
// //           setState(() => _currentStep = AuthStep.register);
// //         }),
// //       ],
// //     );
// //   }

// //   Widget _buildRegisterSheet() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         _dragHandle(),
// //         _sheetHeader('Create Account', subtitle: 'Tell us a bit about yourself'),
// //         TextField(
// //           controller: _nameController,
// //           decoration:
// //               _inputDecoration('Full Name', icon: Icons.person_outline_rounded),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _registerMobileController,
// //           keyboardType: TextInputType.phone,
// //           decoration:
// //               _inputDecoration('Mobile Number', icon: Icons.phone_outlined),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _emailController,
// //           keyboardType: TextInputType.emailAddress,
// //           decoration:
// //               _inputDecoration('Email Address', icon: Icons.mail_outline_rounded),
// //         ),
// //         const SizedBox(height: 12),
// //         DropdownButtonFormField<String>(
// //           value: _selectedCategory,
// //           hint: const Text(
// //             'Select Category',
// //             style: TextStyle(color: _hintGrey, fontSize: 14),
// //           ),
// //           decoration: InputDecoration(
// //             prefixIcon:
// //                 const Icon(Icons.category_outlined, color: _hintGrey, size: 20),
// //             contentPadding:
// //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// //             filled: true,
// //             fillColor: Colors.white,
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: _border),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: _black, width: 1.5),
// //             ),
// //           ),
// //           icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _hintGrey),
// //           items: _categories.map((c) {
// //             return DropdownMenuItem(
// //               value: c,
// //               child: Text(c,
// //                   style: const TextStyle(
// //                       fontSize: 14, fontWeight: FontWeight.w500)),
// //             );
// //           }).toList(),
// //           onChanged: (val) => setState(() => _selectedCategory = val),
// //         ),
// //         const SizedBox(height: 24),
// //         _primaryButton('Create Account', () {
// //           _navigateByCategory(_selectedCategory);
// //         }),
// //         const SizedBox(height: 12),
// //         const Text(
// //           'By registering, you agree to our Terms & Privacy Policy',
// //           textAlign: TextAlign.center,
// //           style: TextStyle(fontSize: 11.5, color: Color(0xFFAAAAAA), height: 1.5),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _currentSheetContent() {
// //     return AnimatedSwitcher(
// //       duration: const Duration(milliseconds: 300),
// //       transitionBuilder: (child, animation) {
// //         return SlideTransition(
// //           position: Tween<Offset>(
// //             begin: const Offset(0, 0.08),
// //             end: Offset.zero,
// //           ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
// //           child: FadeTransition(opacity: animation, child: child),
// //         );
// //       },
// //       child: KeyedSubtree(
// //         key: ValueKey(_currentStep),
// //         child: switch (_currentStep) {
// //           AuthStep.requestOtp => _buildRequestOtpSheet(),
// //           AuthStep.verifyOtp => _buildVerifyOtpSheet(),
// //           AuthStep.register => _buildRegisterSheet(),
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       backgroundColor: const Color(0xFF000000),
// //       body: Stack(
// //         children: [
// //           // Full-bleed background image
// //           Positioned.fill(
// //             child: Image.asset(
// //               'assets/onboardingimage.png',
// //               fit: BoxFit.cover,
// //               alignment: Alignment.topCenter,
// //               errorBuilder: (context, error, stackTrace) {
// //                 return Container(
// //                   decoration: const BoxDecoration(
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topCenter,
// //                       end: Alignment.bottomCenter,
// //                       colors: [
// //                         Color(0xFF2A1F14),
// //                         Color(0xFF0A0A0A),
// //                       ],
// //                     ),
// //                   ),
// //                   child: const Center(
// //                     child: Icon(Icons.checkroom_rounded,
// //                         size: 80, color: Color(0xFFCFB896)),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),

// //           // Gradient scrim at bottom so sheet feels grounded
// //           Positioned(
// //             left: 0,
// //             right: 0,
// //             bottom: 0,
// //             height: 300,
// //             child: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   colors: [
// //                     Colors.transparent,
// //                     Color(0xCC000000),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Top logo/branding
// //           Positioned(
// //             top: MediaQuery.of(context).padding.top + 20,
// //             left: 0,
// //             right: 0,
// //             child: const Center(
// //               child: Text(
// //                 'BRUBLA',
// //                 style: TextStyle(
// //                   fontSize: 13,
// //                   fontWeight: FontWeight.w800,
// //                   color: Colors.white,
// //                   letterSpacing: 4,
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Bottom sheet
// //           AnimatedPositioned(
// //             duration: const Duration(milliseconds: 150),
// //             curve: Curves.easeOut,
// //             left: 0,
// //             right: 0,
// //             bottom: keyboardHeight,
// //             child: Material(
// //               color: Colors.transparent,
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: _bg,
// //                   borderRadius:
// //                       const BorderRadius.vertical(top: Radius.circular(28)),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.25),
// //                       blurRadius: 40,
// //                       offset: const Offset(0, -8),
// //                     ),
// //                   ],
// //                 ),
// //                 padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
// //                 child: _currentSheetContent(),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

import 'package:brublaapp/provider/dessigner/designer_provider.dart';
import 'package:brublaapp/provider/navbar/navbar_provider.dart';
import 'package:brublaapp/provider/navbar/tailor/tailor_navbar_provider.dart';
import 'package:brublaapp/provider/stylist/stylist_navbar_provider.dart';
import 'package:brublaapp/views/Stylistmodule/navbar/navbar_screen.dart';
import 'package:brublaapp/views/Tailormodule/navbar/navbar_screen.dart';
import 'package:brublaapp/views/navbar/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStep { requestOtp, verifyOtp, register }

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

    // Sheet entrance animation
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

    // Pulse animation for primary button (loops subtly)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start entrance after a short delay (gives gold overlay time to fade)
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
    _sheetEntranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _navigateByCategory(String? category) {
    if (category == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
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

  InputDecoration _inputDecoration(String hint, {bool isError = false}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintGrey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isError ? const Color(0xFFCFB896) : _border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isError ? const Color(0xFFCFB896) : _tan,
          width: 1.5,
        ),
      ),
      filled: true,
      fillColor: isError ? _errorFill : Colors.white,
    );
  }

  /// Primary button — black for Request OTP / Verify, tan for Register
  Widget _primaryButton(
    String label,
    VoidCallback onTap, {
    bool isBlack = true,
  }) {
    final bgColor = isBlack ? _black : _tan;

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Transform.scale(
          // Only pulse the black button
          scale: isBlack ? _pulseAnimation.value : 1.0,
          child: child,
        );
      },
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

  Widget _buildRequestOtpSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        // Logo / brand accent
        Center(
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
            child: const Icon(
              Icons.checkroom_rounded,
              color: Color(0xFFC8A96E),
              size: 24,
            ),
          ),
        ),
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
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF888888),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 24),
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

  Widget _buildVerifyOtpSheet() {
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
              color: _black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lock_open_rounded,
              color: Color(0xFFC8A96E),
              size: 22,
            ),
          ),
        ),
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

  Widget _buildRegisterSheet() {
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
              // color: _tan,
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
          items: _categories.map((c) {
            return DropdownMenuItem(
              value: c,
              child: Text(c, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedCategory = val),
        ),
        const SizedBox(height: 20),
        _primaryButton(
          'Register',
          () => _navigateByCategory(_selectedCategory),
          isBlack: false,
        ),
      ],
    );
  }

  Widget _currentSheetContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
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
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/onboardingimage.png',
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),

          // Animated bottom sheet
          AnimatedBuilder(
            animation: _sheetEntranceController,
            builder: (context, child) {
              return AnimatedPositioned(
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
              );
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 28,
                      offset: Offset(0, -6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
                child: _currentSheetContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
