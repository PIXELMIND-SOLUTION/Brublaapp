// // import 'package:brublaapp/views/auth/auth_screen.dart';
// // import 'package:flutter/material.dart';

// // class OnboardingScreen extends StatefulWidget {
// //   const OnboardingScreen({super.key});

// //   @override
// //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // }

// // class _OnboardingScreenState extends State<OnboardingScreen>
// //     with TickerProviderStateMixin {
// //   late AnimationController _phoneController;
// //   late AnimationController _contentController;
// //   late AnimationController _buttonController;
// //   late AnimationController _floatingController;
// //   late AnimationController _shimmerController;

// //   // Phone animations
// //   late Animation<double> _phoneSlideAnimation;
// //   late Animation<double> _phoneScaleAnimation;
// //   late Animation<double> _phoneFadeAnimation;

// //   // Content animations
// //   late Animation<double> _titleSlideAnimation;
// //   late Animation<double> _titleFadeAnimation;
// //   late Animation<double> _subtitleSlideAnimation;
// //   late Animation<double> _subtitleFadeAnimation;

// //   // Button animations
// //   late Animation<double> _buttonScaleAnimation;
// //   late Animation<double> _buttonFadeAnimation;

// //   // Floating/idle animation
// //   late Animation<double> _floatingAnimation;

// //   // Shimmer animation
// //   late Animation<double> _shimmerAnimation;

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Phone entrance animation
// //     _phoneController = AnimationController(
// //       duration: const Duration(milliseconds: 900),
// //       vsync: this,
// //     );

// //     _phoneSlideAnimation = Tween<double>(begin: -80, end: 0).animate(
// //       CurvedAnimation(parent: _phoneController, curve: Curves.easeOutCubic),
// //     );
// //     _phoneScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
// //       CurvedAnimation(parent: _phoneController, curve: Curves.easeOutBack),
// //     );
// //     _phoneFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _phoneController,
// //         curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
// //       ),
// //     );

// //     // Content animation
// //     _contentController = AnimationController(
// //       duration: const Duration(milliseconds: 700),
// //       vsync: this,
// //     );

// //     _titleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
// //       CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
// //     );
// //     _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _contentController,
// //         curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
// //       ),
// //     );
// //     _subtitleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
// //       CurvedAnimation(
// //         parent: _contentController,
// //         curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
// //       ),
// //     );
// //     _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(
// //         parent: _contentController,
// //         curve: const Interval(0.2, 0.9, curve: Curves.easeIn),
// //       ),
// //     );

// //     // Button animation
// //     _buttonController = AnimationController(
// //       duration: const Duration(milliseconds: 600),
// //       vsync: this,
// //     );
// //     _buttonScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
// //       CurvedAnimation(parent: _buttonController, curve: Curves.easeOutBack),
// //     );
// //     _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(parent: _buttonController, curve: Curves.easeIn),
// //     );

// //     // Floating idle animation (looping)
// //     _floatingController = AnimationController(
// //       duration: const Duration(milliseconds: 2800),
// //       vsync: this,
// //     )..repeat(reverse: true);

// //     _floatingAnimation = Tween<double>(begin: 0, end: 10).animate(
// //       CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
// //     );

// //     // Shimmer animation (looping)
// //     _shimmerController = AnimationController(
// //       duration: const Duration(milliseconds: 2000),
// //       vsync: this,
// //     )..repeat();

// //     _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
// //       CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
// //     );

// //     // Staggered start
// //     _startAnimations();
// //   }

// //   Future<void> _startAnimations() async {
// //     await Future.delayed(const Duration(milliseconds: 200));
// //     _phoneController.forward();

// //     await Future.delayed(const Duration(milliseconds: 500));
// //     _contentController.forward();

// //     await Future.delayed(const Duration(milliseconds: 400));
// //     _buttonController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _phoneController.dispose();
// //     _contentController.dispose();
// //     _buttonController.dispose();
// //     _floatingController.dispose();
// //     _shimmerController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;

// //     return Scaffold(
// //       // backgroundColor: Colors.white,
// //             backgroundColor: const Color.fromARGB(255, 0, 0, 0),

// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             // Top image area with beige background
// //             Expanded(
// //               flex: 6,
// //               child: Container(
// //                 width: double.infinity,
// //                 color: const Color(0xFFF5F0EA),
// //                 child: Stack(
// //                   alignment: Alignment.center,
// //                   children: [
// //                     // Decorative background circles
// //                     _buildDecorativeCircles(),

// //                     // Phone mockup with animations
// //                     AnimatedBuilder(
// //                       animation: Listenable.merge([
// //                         _phoneController,
// //                         _floatingController,
// //                       ]),
// //                       builder: (context, child) {
// //                         return Transform.translate(
// //                           offset: Offset(
// //                             0,
// //                             _phoneSlideAnimation.value +
// //                                 (-_floatingAnimation.value),
// //                           ),
// //                           child: Transform.scale(
// //                             scale: _phoneScaleAnimation.value,
// //                             child: Opacity(
// //                               opacity: _phoneFadeAnimation.value,
// //                               child: child,
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                       child: _buildPhoneMockup(size),
// //                     ),
                   
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             // Bottom content area
// //             Expanded(
// //               flex: 4,
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 28.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     // Title
// //                     AnimatedBuilder(
// //                       animation: _contentController,
// //                       builder: (context, child) {
// //                         return Opacity(
// //                           opacity: _titleFadeAnimation.value,
// //                           child: Transform.translate(
// //                             offset: Offset(0, _titleSlideAnimation.value),
// //                             child: child,
// //                           ),
// //                         );
// //                       },
// //                       child: const Text(
// //                         'Explore New Fashion',
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 26,
// //                           fontWeight: FontWeight.w700,
// //                           color: Color.fromARGB(255, 248, 248, 248),
// //                           letterSpacing: -0.5,
// //                           height: 1.2,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 14),

// //                     // Subtitle
// //                     AnimatedBuilder(
// //                       animation: _contentController,
// //                       builder: (context, child) {
// //                         return Opacity(
// //                           opacity: _subtitleFadeAnimation.value,
// //                           child: Transform.translate(
// //                             offset: Offset(0, _subtitleSlideAnimation.value),
// //                             child: child,
// //                           ),
// //                         );
// //                       },
// //                       child: const Text(
// //                         'Virtually try on thousands of outfits and discover your perfect style from the comfort of your home.',
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 14.5,
// //                           fontWeight: FontWeight.w400,
// //                           color: Color.fromARGB(255, 255, 255, 255),
// //                           height: 1.6,
// //                           letterSpacing: 0.1,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(height: 32),

// //                     // CTA Button
// //                     AnimatedBuilder(
// //                       animation: _buttonController,
// //                       builder: (context, child) {
// //                         return Opacity(
// //                           opacity: _buttonFadeAnimation.value,
// //                           child: Transform.scale(
// //                             scale: _buttonScaleAnimation.value,
// //                             child: child,
// //                           ),
// //                         );
// //                       },
// //                       child: _buildAnimatedButton(),
// //                     ),

// //                     const SizedBox(height: 20),

// //                     // Page indicator dots
// //                     // AnimatedBuilder(
// //                     //   animation: _buttonController,
// //                     //   builder: (context, child) {
// //                     //     return Opacity(
// //                     //       opacity: _buttonFadeAnimation.value,
// //                     //       child: child,
// //                     //     );
// //                     //   },
// //                     //   child: _buildPageIndicators(),
// //                     // ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDecorativeCircles() {
// //     return AnimatedBuilder(
// //       animation: _floatingController,
// //       builder: (context, _) {
// //         return Stack(
// //           children: [
// //             Positioned(
// //               top: 20 - _floatingAnimation.value * 0.3,
// //               left: 30,
// //               child: Container(
// //                 width: 60,
// //                 height: 60,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: const Color(0xFFE8DDD0).withOpacity(0.5),
// //                 ),
// //               ),
// //             ),
// //             Positioned(
// //               bottom: 30 + _floatingAnimation.value * 0.4,
// //               right: 20,
// //               child: Container(
// //                 width: 40,
// //                 height: 40,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: const Color(0xFFD4C5B0).withOpacity(0.4),
// //                 ),
// //               ),
// //             ),
// //             Positioned(
// //               top: 60 + _floatingAnimation.value * 0.2,
// //               right: 40,
// //               child: Container(
// //                 width: 20,
// //                 height: 20,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: const Color(0xFFC8B89A).withOpacity(0.35),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildPhoneMockup(Size size) {
// //     return Container(
// //       width: size.width * 0.58,
// //       height: size.height * 0.42,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(36),
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.13),
// //             blurRadius: 40,
// //             offset: const Offset(0, 16),
// //             spreadRadius: 0,
// //           ),
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 12,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(36),
// //         child: Stack(
// //           children: [
// //             // Only the fashion image
// //             Image.asset(
// //               'assets/onboardingimage.png',
// //               fit: BoxFit.cover,
// //               width: double.infinity,
// //               height: double.infinity,
// //               errorBuilder: (context, error, stackTrace) {
// //                 return Container(
// //                   color: const Color(0xFFF0EAE0),
// //                   child: const Center(
// //                     child: Icon(
// //                       Icons.checkroom_rounded,
// //                       size: 64,
// //                       color: Color(0xFFB0A090),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //             // Shimmer overlay
// //             AnimatedBuilder(
// //               animation: _shimmerController,
// //               builder: (context, _) {
// //                 return Positioned.fill(
// //                   child: IgnorePointer(
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         gradient: LinearGradient(
// //                           begin: Alignment(
// //                             -1.5 + _shimmerAnimation.value * 1.5,
// //                             -0.5,
// //                           ),
// //                           end: Alignment(
// //                             -0.5 + _shimmerAnimation.value * 1.5,
// //                             0.5,
// //                           ),
// //                           colors: [
// //                             Colors.white.withOpacity(0.0),
// //                             Colors.white.withOpacity(0.07),
// //                             Colors.white.withOpacity(0.0),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAnimatedButton() {
// //     return _PressableButton(
// //       onTap: () {

// //         Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
// //       },
// //       child: Container(
// //         width: double.infinity,
// //         height: 54,
// //         decoration: BoxDecoration(
// //           color: const Color(0xFFC8A96E),
// //           borderRadius: BorderRadius.circular(16),
// //           boxShadow: [
// //             BoxShadow(
// //               color: const Color(0xFFC8A96E).withOpacity(0.35),
// //               blurRadius: 20,
// //               offset: const Offset(0, 8),
// //               spreadRadius: 0,
// //             ),
// //           ],
// //         ),
// //         child: const Center(
// //           child: Text(
// //             "Let's Go",
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.w600,
// //               color: Colors.white,
// //               letterSpacing: 0.3,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// // }

// // // Pressable button with scale feedback
// // class _PressableButton extends StatefulWidget {
// //   final Widget child;
// //   final VoidCallback onTap;

// //   const _PressableButton({required this.child, required this.onTap});

// //   @override
// //   State<_PressableButton> createState() => _PressableButtonState();
// // }

// // class _PressableButtonState extends State<_PressableButton>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _scaleAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       duration: const Duration(milliseconds: 120),
// //       vsync: this,
// //     );
// //     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
// //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTapDown: (_) => _controller.forward(),
// //       onTapUp: (_) {
// //         _controller.reverse();
// //         widget.onTap();
// //       },
// //       onTapCancel: () => _controller.reverse(),
// //       child: AnimatedBuilder(
// //         animation: _controller,
// //         builder: (context, child) {
// //           return Transform.scale(
// //             scale: _scaleAnimation.value,
// //             child: child,
// //           );
// //         },
// //         child: widget.child,
// //       ),
// //     );
// //   }
// // }





















// // // import 'package:flutter/material.dart';
// // // import 'package:brublaapp/views/auth/auth_screen.dart';

// // // class OnboardingScreen extends StatefulWidget {
// // //   const OnboardingScreen({super.key});

// // //   @override
// // //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // // }

// // // class _OnboardingScreenState extends State<OnboardingScreen>
// // //     with TickerProviderStateMixin {
// // //   late AnimationController _phoneController;
// // //   late AnimationController _contentController;
// // //   late AnimationController _buttonController;
// // //   late AnimationController _floatingController;
// // //   late AnimationController _shimmerController;
// // //   late AnimationController _sheetController;

// // //   // Phone animations
// // //   late Animation<double> _phoneSlideAnimation;
// // //   late Animation<double> _phoneScaleAnimation;
// // //   late Animation<double> _phoneFadeAnimation;

// // //   // Content animations
// // //   late Animation<double> _titleSlideAnimation;
// // //   late Animation<double> _titleFadeAnimation;
// // //   late Animation<double> _subtitleSlideAnimation;
// // //   late Animation<double> _subtitleFadeAnimation;

// // //   // Button animations
// // //   late Animation<double> _buttonScaleAnimation;
// // //   late Animation<double> _buttonFadeAnimation;

// // //   // Floating/idle animation
// // //   late Animation<double> _floatingAnimation;

// // //   // Shimmer animation
// // //   late Animation<double> _shimmerAnimation;

// // //   // Sheet animation
// // //   late Animation<double> _sheetSlideAnimation;
// // //   late Animation<double> _sheetFadeAnimation;
// // //   late Animation<double> _overlayFadeAnimation;

// // //   bool _sheetVisible = false;

// // //   final TextEditingController _mobileController = TextEditingController();

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     _phoneController = AnimationController(
// // //       duration: const Duration(milliseconds: 900),
// // //       vsync: this,
// // //     );

// // //     _phoneSlideAnimation = Tween<double>(begin: -80, end: 0).animate(
// // //       CurvedAnimation(parent: _phoneController, curve: Curves.easeOutCubic),
// // //     );
// // //     _phoneScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
// // //       CurvedAnimation(parent: _phoneController, curve: Curves.easeOutBack),
// // //     );
// // //     _phoneFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _phoneController,
// // //         curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
// // //       ),
// // //     );

// // //     _contentController = AnimationController(
// // //       duration: const Duration(milliseconds: 700),
// // //       vsync: this,
// // //     );

// // //     _titleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
// // //       CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
// // //     );
// // //     _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _contentController,
// // //         curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
// // //       ),
// // //     );
// // //     _subtitleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
// // //       CurvedAnimation(
// // //         parent: _contentController,
// // //         curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
// // //       ),
// // //     );
// // //     _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _contentController,
// // //         curve: const Interval(0.2, 0.9, curve: Curves.easeIn),
// // //       ),
// // //     );

// // //     _buttonController = AnimationController(
// // //       duration: const Duration(milliseconds: 600),
// // //       vsync: this,
// // //     );
// // //     _buttonScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
// // //       CurvedAnimation(parent: _buttonController, curve: Curves.easeOutBack),
// // //     );
// // //     _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(parent: _buttonController, curve: Curves.easeIn),
// // //     );

// // //     _floatingController = AnimationController(
// // //       duration: const Duration(milliseconds: 2800),
// // //       vsync: this,
// // //     )..repeat(reverse: true);

// // //     _floatingAnimation = Tween<double>(begin: 0, end: 10).animate(
// // //       CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
// // //     );

// // //     _shimmerController = AnimationController(
// // //       duration: const Duration(milliseconds: 2000),
// // //       vsync: this,
// // //     )..repeat();

// // //     _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
// // //       CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
// // //     );

// // //     // Sheet slide-up animation
// // //     _sheetController = AnimationController(
// // //       duration: const Duration(milliseconds: 480),
// // //       vsync: this,
// // //     );

// // //     _sheetSlideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
// // //       CurvedAnimation(parent: _sheetController, curve: Curves.easeOutCubic),
// // //     );
// // //     _sheetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _sheetController,
// // //         curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
// // //       ),
// // //     );
// // //     _overlayFadeAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
// // //       CurvedAnimation(parent: _sheetController, curve: Curves.easeIn),
// // //     );

// // //     _startAnimations();
// // //   }

// // //   Future<void> _startAnimations() async {
// // //     await Future.delayed(const Duration(milliseconds: 200));
// // //     _phoneController.forward();
// // //     await Future.delayed(const Duration(milliseconds: 500));
// // //     _contentController.forward();
// // //     await Future.delayed(const Duration(milliseconds: 400));
// // //     _buttonController.forward();
// // //   }

// // //   void _showSheet() {
// // //     setState(() => _sheetVisible = true);
// // //     _sheetController.forward();
// // //   }

// // //   Future<void> _hideSheet() async {
// // //     await _sheetController.reverse();
// // //     setState(() => _sheetVisible = false);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _phoneController.dispose();
// // //     _contentController.dispose();
// // //     _buttonController.dispose();
// // //     _floatingController.dispose();
// // //     _shimmerController.dispose();
// // //     _sheetController.dispose();
// // //     _mobileController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = MediaQuery.of(context).size;

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFF000000),
// // //       body: SafeArea(
// // //         child: Stack(
// // //           children: [
// // //             Column(
// // //               children: [
// // //                 // Top image area
// // //                 Expanded(
// // //                   flex: 6,
// // //                   child: Container(
// // //                     width: double.infinity,
// // //                     color: const Color(0xFFF5F0EA),
// // //                     child: Stack(
// // //                       alignment: Alignment.center,
// // //                       children: [
// // //                         _buildDecorativeCircles(),
// // //                         AnimatedBuilder(
// // //                           animation: Listenable.merge([
// // //                             _phoneController,
// // //                             _floatingController,
// // //                           ]),
// // //                           builder: (context, child) {
// // //                             return Transform.translate(
// // //                               offset: Offset(
// // //                                 0,
// // //                                 _phoneSlideAnimation.value +
// // //                                     (-_floatingAnimation.value),
// // //                               ),
// // //                               child: Transform.scale(
// // //                                 scale: _phoneScaleAnimation.value,
// // //                                 child: Opacity(
// // //                                   opacity: _phoneFadeAnimation.value,
// // //                                   child: child,
// // //                                 ),
// // //                               ),
// // //                             );
// // //                           },
// // //                           child: _buildPhoneMockup(size),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),

// // //                 // Bottom content area
// // //                 Expanded(
// // //                   flex: 4,
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 28.0),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.center,
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         AnimatedBuilder(
// // //                           animation: _contentController,
// // //                           builder: (context, child) {
// // //                             return Opacity(
// // //                               opacity: _titleFadeAnimation.value,
// // //                               child: Transform.translate(
// // //                                 offset: Offset(0, _titleSlideAnimation.value),
// // //                                 child: child,
// // //                               ),
// // //                             );
// // //                           },
// // //                           child: const Text(
// // //                             'Explore New Fashion',
// // //                             textAlign: TextAlign.center,
// // //                             style: TextStyle(
// // //                               fontSize: 26,
// // //                               fontWeight: FontWeight.w700,
// // //                               color: Color.fromARGB(255, 248, 248, 248),
// // //                               letterSpacing: -0.5,
// // //                               height: 1.2,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 14),
// // //                         AnimatedBuilder(
// // //                           animation: _contentController,
// // //                           builder: (context, child) {
// // //                             return Opacity(
// // //                               opacity: _subtitleFadeAnimation.value,
// // //                               child: Transform.translate(
// // //                                 offset:
// // //                                     Offset(0, _subtitleSlideAnimation.value),
// // //                                 child: child,
// // //                               ),
// // //                             );
// // //                           },
// // //                           child: const Text(
// // //                             'Virtually try on thousands of outfits and discover your perfect style from the comfort of your home.',
// // //                             textAlign: TextAlign.center,
// // //                             style: TextStyle(
// // //                               fontSize: 14.5,
// // //                               fontWeight: FontWeight.w400,
// // //                               color: Color.fromARGB(255, 255, 255, 255),
// // //                               height: 1.6,
// // //                               letterSpacing: 0.1,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 32),
// // //                         AnimatedBuilder(
// // //                           animation: _buttonController,
// // //                           builder: (context, child) {
// // //                             return Opacity(
// // //                               opacity: _buttonFadeAnimation.value,
// // //                               child: Transform.scale(
// // //                                 scale: _buttonScaleAnimation.value,
// // //                                 child: child,
// // //                               ),
// // //                             );
// // //                           },
// // //                           child: _buildAnimatedButton(),
// // //                         ),
// // //                         const SizedBox(height: 20),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),

// // //             // Dim overlay
// // //             if (_sheetVisible)
// // //               AnimatedBuilder(
// // //                 animation: _sheetController,
// // //                 builder: (context, _) {
// // //                   return GestureDetector(
// // //                     onTap: _hideSheet,
// // //                     child: Container(
// // //                       color:
// // //                           Colors.black.withOpacity(_overlayFadeAnimation.value),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),

// // //             // Slide-up OTP sheet
// // //             if (_sheetVisible)
// // //               AnimatedBuilder(
// // //                 animation: _sheetController,
// // //                 builder: (context, child) {
// // //                   return Positioned(
// // //                     left: 0,
// // //                     right: 0,
// // //                     bottom: 0,
// // //                     child: Transform.translate(
// // //                       offset: Offset(
// // //                         0,
// // //                         _sheetSlideAnimation.value *
// // //                             (size.height * 0.45),
// // //                       ),
// // //                       child: Opacity(
// // //                         opacity: _sheetFadeAnimation.value,
// // //                         child: child,
// // //                       ),
// // //                     ),
// // //                   );
// // //                 },
// // //                 child: _buildOtpSheet(context),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildOtpSheet(BuildContext context) {
// // //     return Container(
// // //       decoration: const BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Color(0x30000000),
// // //             blurRadius: 40,
// // //             offset: Offset(0, -8),
// // //           ),
// // //         ],
// // //       ),
// // //       padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
// // //       child: Column(
// // //         mainAxisSize: MainAxisSize.min,
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // Drag handle
// // //           Center(
// // //             child: Container(
// // //               width: 40,
// // //               height: 4,
// // //               margin: const EdgeInsets.only(bottom: 24),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.grey[300],
// // //                 borderRadius: BorderRadius.circular(2),
// // //               ),
// // //             ),
// // //           ),

// // //           // Brand tag
// // //           Center(
// // //             child: Container(
// // //               padding:
// // //                   const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
// // //               margin: const EdgeInsets.only(bottom: 16),
// // //               decoration: BoxDecoration(
// // //                 color: const Color(0xFFF5F0EA),
// // //                 borderRadius: BorderRadius.circular(20),
// // //               ),
// // //               child: const Text(
// // //                 '✦  BRUBLA',
// // //                 style: TextStyle(
// // //                   fontSize: 11,
// // //                   fontWeight: FontWeight.w700,
// // //                   color: Color(0xFFB8966E),
// // //                   letterSpacing: 2.5,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           const Center(
// // //             child: Text(
// // //               'Happy Shopping',
// // //               style: TextStyle(
// // //                 fontSize: 24,
// // //                 fontWeight: FontWeight.w800,
// // //                 color: Color(0xFF0A0A0A),
// // //                 letterSpacing: -0.5,
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 6),
// // //           const Center(
// // //             child: Text(
// // //               'Enter your number to get started',
// // //               style: TextStyle(
// // //                 fontSize: 13.5,
// // //                 color: Color(0xFF888888),
// // //                 fontWeight: FontWeight.w400,
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 28),

// // //           // Phone field with prefix
// // //           Container(
// // //             decoration: BoxDecoration(
// // //               color: const Color(0xFFF8F8F8),
// // //               borderRadius: BorderRadius.circular(12),
// // //               border: Border.all(color: const Color(0xFFE8E8E8)),
// // //             ),
// // //             child: Row(
// // //               children: [
// // //                 Container(
// // //                   padding: const EdgeInsets.symmetric(
// // //                       horizontal: 14, vertical: 16),
// // //                   decoration: const BoxDecoration(
// // //                     border: Border(
// // //                         right: BorderSide(color: Color(0xFFE8E8E8))),
// // //                   ),
// // //                   child: const Text(
// // //                     '🇮🇳  +91',
// // //                     style: TextStyle(
// // //                       fontSize: 14,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: Color(0xFF333333),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Expanded(
// // //                   child: TextField(
// // //                     controller: _mobileController,
// // //                     keyboardType: TextInputType.phone,
// // //                     style: const TextStyle(
// // //                       fontSize: 15,
// // //                       fontWeight: FontWeight.w500,
// // //                       color: Color(0xFF111111),
// // //                     ),
// // //                     decoration: const InputDecoration(
// // //                       hintText: 'Mobile Number',
// // //                       hintStyle: TextStyle(
// // //                           color: Color(0xFFAAAAAA), fontSize: 14),
// // //                       contentPadding: EdgeInsets.symmetric(
// // //                           horizontal: 14, vertical: 16),
// // //                       border: InputBorder.none,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           const SizedBox(height: 20),

// // //           // Black CTA button
// // //           GestureDetector(
// // //             onTap: () {
// // //               Navigator.pushReplacement(
// // //                 context,
// // //                 PageRouteBuilder(
// // //                   pageBuilder: (_, animation, __) => const AuthScreen(),
// // //                   transitionsBuilder: (_, animation, __, child) {
// // //                     return SlideTransition(
// // //                       position: Tween<Offset>(
// // //                         begin: const Offset(0, 1),
// // //                         end: Offset.zero,
// // //                       ).animate(CurvedAnimation(
// // //                           parent: animation, curve: Curves.easeOutCubic)),
// // //                       child: child,
// // //                     );
// // //                   },
// // //                   transitionDuration: const Duration(milliseconds: 400),
// // //                 ),
// // //               );
// // //             },
// // //             child: Container(
// // //               width: double.infinity,
// // //               height: 54,
// // //               decoration: BoxDecoration(
// // //                 color: const Color(0xFF0A0A0A),
// // //                 borderRadius: BorderRadius.circular(14),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.black.withOpacity(0.25),
// // //                     blurRadius: 16,
// // //                     offset: const Offset(0, 6),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: const Center(
// // //                 child: Text(
// // //                   'Request OTP',
// // //                   style: TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.w700,
// // //                     color: Colors.white,
// // //                     letterSpacing: 0.3,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           const SizedBox(height: 16),
// // //           const Center(
// // //             child: Text(
// // //               'By continuing, you agree to our Terms & Privacy Policy',
// // //               textAlign: TextAlign.center,
// // //               style: TextStyle(
// // //                 fontSize: 11.5,
// // //                 color: Color(0xFFAAAAAA),
// // //                 height: 1.5,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDecorativeCircles() {
// // //     return AnimatedBuilder(
// // //       animation: _floatingController,
// // //       builder: (context, _) {
// // //         return Stack(
// // //           children: [
// // //             Positioned(
// // //               top: 20 - _floatingAnimation.value * 0.3,
// // //               left: 30,
// // //               child: Container(
// // //                 width: 60,
// // //                 height: 60,
// // //                 decoration: BoxDecoration(
// // //                   shape: BoxShape.circle,
// // //                   color: const Color(0xFFE8DDD0).withOpacity(0.5),
// // //                 ),
// // //               ),
// // //             ),
// // //             Positioned(
// // //               bottom: 30 + _floatingAnimation.value * 0.4,
// // //               right: 20,
// // //               child: Container(
// // //                 width: 40,
// // //                 height: 40,
// // //                 decoration: BoxDecoration(
// // //                   shape: BoxShape.circle,
// // //                   color: const Color(0xFFD4C5B0).withOpacity(0.4),
// // //                 ),
// // //               ),
// // //             ),
// // //             Positioned(
// // //               top: 60 + _floatingAnimation.value * 0.2,
// // //               right: 40,
// // //               child: Container(
// // //                 width: 20,
// // //                 height: 20,
// // //                 decoration: BoxDecoration(
// // //                   shape: BoxShape.circle,
// // //                   color: const Color(0xFFC8B89A).withOpacity(0.35),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildPhoneMockup(Size size) {
// // //     return Container(
// // //       width: size.width * 0.58,
// // //       height: size.height * 0.42,
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(36),
// // //         color: Colors.white,
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.13),
// // //             blurRadius: 40,
// // //             offset: const Offset(0, 16),
// // //           ),
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.06),
// // //             blurRadius: 12,
// // //             offset: const Offset(0, 4),
// // //           ),
// // //         ],
// // //       ),
// // //       child: ClipRRect(
// // //         borderRadius: BorderRadius.circular(36),
// // //         child: Stack(
// // //           children: [
// // //             Image.asset(
// // //               'assets/onboardingimage.png',
// // //               fit: BoxFit.cover,
// // //               width: double.infinity,
// // //               height: double.infinity,
// // //               errorBuilder: (context, error, stackTrace) {
// // //                 return Container(
// // //                   color: const Color(0xFFF0EAE0),
// // //                   child: const Center(
// // //                     child: Icon(Icons.checkroom_rounded,
// // //                         size: 64, color: Color(0xFFB0A090)),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //             AnimatedBuilder(
// // //               animation: _shimmerController,
// // //               builder: (context, _) {
// // //                 return Positioned.fill(
// // //                   child: IgnorePointer(
// // //                     child: Container(
// // //                       decoration: BoxDecoration(
// // //                         gradient: LinearGradient(
// // //                           begin: Alignment(
// // //                               -1.5 + _shimmerAnimation.value * 1.5, -0.5),
// // //                           end: Alignment(
// // //                               -0.5 + _shimmerAnimation.value * 1.5, 0.5),
// // //                           colors: [
// // //                             Colors.white.withOpacity(0.0),
// // //                             Colors.white.withOpacity(0.07),
// // //                             Colors.white.withOpacity(0.0),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAnimatedButton() {
// // //     return _PressableButton(
// // //       onTap: _showSheet,
// // //       child: Container(
// // //         width: double.infinity,
// // //         height: 54,
// // //         decoration: BoxDecoration(
// // //           color: const Color(0xFFC8A96E),
// // //           borderRadius: BorderRadius.circular(16),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.35),
// // //               blurRadius: 20,
// // //               offset: const Offset(0, 8),
// // //             ),
// // //           ],
// // //         ),
// // //         child: const Center(
// // //           child: Text(
// // //             "Let's Go",
// // //             style: TextStyle(
// // //               fontSize: 16,
// // //               fontWeight: FontWeight.w600,
// // //               color: Colors.white,
// // //               letterSpacing: 0.3,
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class _PressableButton extends StatefulWidget {
// // //   final Widget child;
// // //   final VoidCallback onTap;

// // //   const _PressableButton({required this.child, required this.onTap});

// // //   @override
// // //   State<_PressableButton> createState() => _PressableButtonState();
// // // }

// // // class _PressableButtonState extends State<_PressableButton>
// // //     with SingleTickerProviderStateMixin {
// // //   late AnimationController _controller;
// // //   late Animation<double> _scaleAnimation;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _controller = AnimationController(
// // //       duration: const Duration(milliseconds: 120),
// // //       vsync: this,
// // //     );
// // //     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
// // //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _controller.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GestureDetector(
// // //       onTapDown: (_) => _controller.forward(),
// // //       onTapUp: (_) {
// // //         _controller.reverse();
// // //         widget.onTap();
// // //       },
// // //       onTapCancel: () => _controller.reverse(),
// // //       child: AnimatedBuilder(
// // //         animation: _controller,
// // //         builder: (context, child) {
// // //           return Transform.scale(scale: _scaleAnimation.value, child: child);
// // //         },
// // //         child: widget.child,
// // //       ),
// // //     );
// // //   }
// // // }



























// import 'package:brublaapp/views/auth/auth_screen.dart';
// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _phoneController;
//   late AnimationController _contentController;
//   late AnimationController _buttonController;
//   late AnimationController _floatingController;
//   late AnimationController _shimmerController;

//   // Transition animation controller
//   late AnimationController _transitionController;

//   // Phone animations
//   late Animation<double> _phoneSlideAnimation;
//   late Animation<double> _phoneScaleAnimation;
//   late Animation<double> _phoneFadeAnimation;

//   // Content animations
//   late Animation<double> _titleSlideAnimation;
//   late Animation<double> _titleFadeAnimation;
//   late Animation<double> _subtitleSlideAnimation;
//   late Animation<double> _subtitleFadeAnimation;

//   // Button animations
//   late Animation<double> _buttonScaleAnimation;
//   late Animation<double> _buttonFadeAnimation;

//   // Floating/idle animation
//   late Animation<double> _floatingAnimation;

//   // Shimmer animation
//   late Animation<double> _shimmerAnimation;

//   // Transition animations
//   late Animation<double> _overlayExpandAnimation;
//   late Animation<double> _contentFadeOutAnimation;
//   late Animation<double> _phoneZoomAnimation;

//   bool _isTransitioning = false;

//   @override
//   void initState() {
//     super.initState();

//     // Phone entrance animation
//     _phoneController = AnimationController(
//       duration: const Duration(milliseconds: 900),
//       vsync: this,
//     );

//     _phoneSlideAnimation = Tween<double>(begin: -80, end: 0).animate(
//       CurvedAnimation(parent: _phoneController, curve: Curves.easeOutCubic),
//     );
//     _phoneScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
//       CurvedAnimation(parent: _phoneController, curve: Curves.easeOutBack),
//     );
//     _phoneFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _phoneController,
//         curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
//       ),
//     );

//     // Content animation
//     _contentController = AnimationController(
//       duration: const Duration(milliseconds: 700),
//       vsync: this,
//     );

//     _titleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
//       CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
//     );
//     _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _contentController,
//         curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
//       ),
//     );
//     _subtitleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
//       CurvedAnimation(
//         parent: _contentController,
//         curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
//       ),
//     );
//     _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _contentController,
//         curve: const Interval(0.2, 0.9, curve: Curves.easeIn),
//       ),
//     );

//     // Button animation
//     _buttonController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _buttonScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _buttonController, curve: Curves.easeOutBack),
//     );
//     _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _buttonController, curve: Curves.easeIn),
//     );

//     // Floating idle animation (looping)
//     _floatingController = AnimationController(
//       duration: const Duration(milliseconds: 2800),
//       vsync: this,
//     )..repeat(reverse: true);

//     _floatingAnimation = Tween<double>(begin: 0, end: 10).animate(
//       CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
//     );

//     // Shimmer animation (looping)
//     _shimmerController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..repeat();

//     _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
//       CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
//     );

//     // Transition animation controller
//     _transitionController = AnimationController(
//       duration: const Duration(milliseconds: 750),
//       vsync: this,
//     );

//     _overlayExpandAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _transitionController,
//         curve: const Interval(0.0, 0.65, curve: Curves.easeInCubic),
//       ),
//     );

//     _contentFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _transitionController,
//         curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
//       ),
//     );

//     _phoneZoomAnimation = Tween<double>(begin: 1.0, end: 2.2).animate(
//       CurvedAnimation(
//         parent: _transitionController,
//         curve: const Interval(0.0, 0.6, curve: Curves.easeInCubic),
//       ),
//     );

//     // Staggered start
//     _startAnimations();
//   }

//   Future<void> _startAnimations() async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     _phoneController.forward();

//     await Future.delayed(const Duration(milliseconds: 500));
//     _contentController.forward();

//     await Future.delayed(const Duration(milliseconds: 400));
//     _buttonController.forward();
//   }

//   Future<void> _handleLetsGoTap() async {
//     if (_isTransitioning) return;
//     setState(() => _isTransitioning = true);

//     // Stop idle animations
//     _floatingController.stop();
//     _shimmerController.stop();

//     // Play transition
//     await _transitionController.forward();

//     if (!mounted) return;

//     // Navigate with a custom page route that continues the reveal
//     Navigator.pushReplacement(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 500),
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             const AuthScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           final curved = CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeOutCubic,
//           );
//           return FadeTransition(
//             opacity: curved,
//             child: SlideTransition(
//               position: Tween<Offset>(
//                 begin: const Offset(0, 0.04),
//                 end: Offset.zero,
//               ).animate(curved),
//               child: child,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _contentController.dispose();
//     _buttonController.dispose();
//     _floatingController.dispose();
//     _shimmerController.dispose();
//     _transitionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 // Top image area with beige background
//                 Expanded(
//                   flex: 6,
//                   child: Container(
//                     width: double.infinity,
//                     color: const Color(0xFFF5F0EA),
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         _buildDecorativeCircles(),

//                         // Phone mockup with animations
//                         AnimatedBuilder(
//                           animation: Listenable.merge([
//                             _phoneController,
//                             _floatingController,
//                             _transitionController,
//                           ]),
//                           builder: (context, child) {
//                             return Transform.translate(
//                               offset: Offset(
//                                 0,
//                                 _phoneSlideAnimation.value +
//                                     (-_floatingAnimation.value),
//                               ),
//                               child: Transform.scale(
//                                 scale: _phoneScaleAnimation.value *
//                                     _phoneZoomAnimation.value,
//                                 child: Opacity(
//                                   opacity: _phoneFadeAnimation.value,
//                                   child: child,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: _buildPhoneMockup(size),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Bottom content area
//                 Expanded(
//                   flex: 4,
//                   child: AnimatedBuilder(
//                     animation: _transitionController,
//                     builder: (context, child) {
//                       return Opacity(
//                         opacity: _contentFadeOutAnimation.value,
//                         child: child,
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           AnimatedBuilder(
//                             animation: _contentController,
//                             builder: (context, child) {
//                               return Opacity(
//                                 opacity: _titleFadeAnimation.value,
//                                 child: Transform.translate(
//                                   offset:
//                                       Offset(0, _titleSlideAnimation.value),
//                                   child: child,
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Explore New Fashion',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color.fromARGB(255, 248, 248, 248),
//                                 letterSpacing: -0.5,
//                                 height: 1.2,
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 14),

//                           AnimatedBuilder(
//                             animation: _contentController,
//                             builder: (context, child) {
//                               return Opacity(
//                                 opacity: _subtitleFadeAnimation.value,
//                                 child: Transform.translate(
//                                   offset: Offset(
//                                       0, _subtitleSlideAnimation.value),
//                                   child: child,
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Virtually try on thousands of outfits and discover your perfect style from the comfort of your home.',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 14.5,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 height: 1.6,
//                                 letterSpacing: 0.1,
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 32),

//                           AnimatedBuilder(
//                             animation: _buttonController,
//                             builder: (context, child) {
//                               return Opacity(
//                                 opacity: _buttonFadeAnimation.value,
//                                 child: Transform.scale(
//                                   scale: _buttonScaleAnimation.value,
//                                   child: child,
//                                 ),
//                               );
//                             },
//                             child: _buildAnimatedButton(),
//                           ),

//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Full-screen transition overlay (gold ripple expanding)
//             if (_isTransitioning)
//               AnimatedBuilder(
//                 animation: _overlayExpandAnimation,
//                 builder: (context, _) {
//                   final val = _overlayExpandAnimation.value;
//                   return IgnorePointer(
//                     child: CustomPaint(
//                       painter: _RippleOverlayPainter(
//                         progress: val,
//                         color: const Color(0xFFC8A96E),
//                       ),
//                       child: const SizedBox.expand(),
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDecorativeCircles() {
//     return AnimatedBuilder(
//       animation: _floatingController,
//       builder: (context, _) {
//         return Stack(
//           children: [
//             Positioned(
//               top: 20 - _floatingAnimation.value * 0.3,
//               left: 30,
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFFE8DDD0).withOpacity(0.5),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 30 + _floatingAnimation.value * 0.4,
//               right: 20,
//               child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFFD4C5B0).withOpacity(0.4),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 60 + _floatingAnimation.value * 0.2,
//               right: 40,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFFC8B89A).withOpacity(0.35),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildPhoneMockup(Size size) {
//     return Container(
//       width: size.width * 0.58,
//       height: size.height * 0.42,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(36),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.13),
//             blurRadius: 40,
//             offset: const Offset(0, 16),
//             spreadRadius: 0,
//           ),
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(36),
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/onboardingimage.png',
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   color: const Color(0xFFF0EAE0),
//                   child: const Center(
//                     child: Icon(
//                       Icons.checkroom_rounded,
//                       size: 64,
//                       color: Color(0xFFB0A090),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             AnimatedBuilder(
//               animation: _shimmerController,
//               builder: (context, _) {
//                 return Positioned.fill(
//                   child: IgnorePointer(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment(
//                             -1.5 + _shimmerAnimation.value * 1.5,
//                             -0.5,
//                           ),
//                           end: Alignment(
//                             -0.5 + _shimmerAnimation.value * 1.5,
//                             0.5,
//                           ),
//                           colors: [
//                             Colors.white.withOpacity(0.0),
//                             Colors.white.withOpacity(0.07),
//                             Colors.white.withOpacity(0.0),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedButton() {
//     return _PressableButton(
//       onTap: _handleLetsGoTap,
//       child: Container(
//         width: double.infinity,
//         height: 54,
//         decoration: BoxDecoration(
//           color: const Color(0xFFC8A96E),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFFC8A96E).withOpacity(0.35),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: const Center(
//           child: Text(
//             "Let's Go",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//               letterSpacing: 0.3,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom painter: gold ripple that expands from bottom-center
// class _RippleOverlayPainter extends CustomPainter {
//   final double progress;
//   final Color color;

//   _RippleOverlayPainter({required this.progress, required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Origin: bottom center (where the button roughly is)
//     final origin = Offset(size.width / 2, size.height * 0.82);

//     // Diagonal of screen so the circle fully covers it
//     final maxRadius =
//         (Offset(0, 0) - origin).distance.clamp(0.0, double.infinity);
//     final maxR = [
//       (Offset(size.width, 0) - origin).distance,
//       (Offset(0, size.height) - origin).distance,
//       (Offset(size.width, size.height) - origin).distance,
//       (Offset(0, 0) - origin).distance,
//     ].reduce((a, b) => a > b ? a : b);

//     final radius = maxR * Curves.easeInCubic.transform(progress);

//     final paint = Paint()
//       ..color = color.withOpacity((1 - progress * 0.3).clamp(0.0, 1.0))
//       ..style = PaintingStyle.fill;

//     canvas.drawCircle(origin, radius, paint);

//     // Inner white trailing circle for depth
//     if (progress > 0.15) {
//       final innerProgress = ((progress - 0.15) / 0.85).clamp(0.0, 1.0);
//       final innerPaint = Paint()
//         ..color = Colors.white.withOpacity(innerProgress * 0.15)
//         ..style = PaintingStyle.fill;
//       canvas.drawCircle(origin, radius * 0.7, innerPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(_RippleOverlayPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }

// // Pressable button with scale feedback
// class _PressableButton extends StatefulWidget {
//   final Widget child;
//   final VoidCallback onTap;

//   const _PressableButton({required this.child, required this.onTap});

//   @override
//   State<_PressableButton> createState() => _PressableButtonState();
// }

// class _PressableButtonState extends State<_PressableButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 120),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _controller.forward(),
//       onTapUp: (_) {
//         _controller.reverse();
//         widget.onTap();
//       },
//       onTapCancel: () => _controller.reverse(),
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _scaleAnimation.value,
//             child: child,
//           );
//         },
//         child: widget.child,
//       ),
//     );
//   }
// }


















import 'dart:math';
import 'package:brublaapp/views/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _phoneController;
  late AnimationController _contentController;
  late AnimationController _buttonController;
  late AnimationController _floatingController;
  late AnimationController _shimmerController;

  // Transition animation controller
  late AnimationController _transitionController;

  // Phone animations
  late Animation<double> _phoneSlideAnimation;
  late Animation<double> _phoneScaleAnimation;
  late Animation<double> _phoneFadeAnimation;

  // Content animations
  late Animation<double> _titleSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _subtitleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;

  // Button animations
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _buttonFadeAnimation;

  // Floating/idle animation
  late Animation<double> _floatingAnimation;

  // Shimmer animation
  late Animation<double> _shimmerAnimation;

  // Transition animations
  late Animation<double> _particleAnimation;
  late Animation<double> _goldWaveAnimation;
  late Animation<double> _pageFadeOutAnimation;
  late Animation<Offset> _slideOutAnimation;
  late Animation<double> _goldGlowAnimation;

  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();

    // Phone entrance animation
    _phoneController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _phoneSlideAnimation = Tween<double>(begin: -80, end: 0).animate(
      CurvedAnimation(parent: _phoneController, curve: Curves.easeOutCubic),
    );
    _phoneScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _phoneController, curve: Curves.easeOutBack),
    );
    _phoneFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _phoneController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Content animation
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _titleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic),
    );
    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );
    _subtitleSlideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.2, 0.9, curve: Curves.easeIn),
      ),
    );

    // Button animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _buttonScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOutBack),
    );
    _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeIn),
    );

    // Floating idle animation (looping)
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Shimmer animation (looping)
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Transition animation controller
    _transitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Particle effect animation
    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.elasticOut,
      ),
    );

    // Gold wave animation
    _goldWaveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Gold glow animation
    _goldGlowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutQuad),
      ),
    );

    // Page fade out animation
    _pageFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Slide out animation
    _slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.2, 0),
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInCubic),
      ),
    );

    // Staggered start
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _phoneController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _contentController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _buttonController.forward();
  }

  Future<void> _handleLetsGoTap() async {
    if (_isTransitioning) return;
    setState(() => _isTransitioning = true);

    // Stop idle animations
    _floatingController.stop();
    _shimmerController.stop();

    // Play transition animation
    await _transitionController.forward();

    if (!mounted) return;

    // Navigate with a smooth fade in + scale transition
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.05);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          var scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );
          
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _contentController.dispose();
    _buttonController.dispose();
    _floatingController.dispose();
    _shimmerController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: AnimatedBuilder(
        animation: _transitionController,
        builder: (context, _) {
          return Stack(
            children: [
              // Main content with slide out animation
              Transform.translate(
                offset: _slideOutAnimation.value * Offset(size.width, 0).dx,
                child: Opacity(
                  opacity: _pageFadeOutAnimation.value,
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Top image area with beige background
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: double.infinity,
                            color: const Color(0xFFF5F0EA),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _buildDecorativeCircles(),
                                // Phone mockup with animations
                                AnimatedBuilder(
                                  animation: Listenable.merge([
                                    _phoneController,
                                    _floatingController,
                                  ]),
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(
                                        0,
                                        _phoneSlideAnimation.value +
                                            (-_floatingAnimation.value),
                                      ),
                                      child: Transform.scale(
                                        scale: _phoneScaleAnimation.value,
                                        child: Opacity(
                                          opacity: _phoneFadeAnimation.value,
                                          child: child,
                                        ),
                                      ),
                                    );
                                  },
                                  child: _buildPhoneMockup(size),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Bottom content area
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _contentController,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _titleFadeAnimation.value,
                                      child: Transform.translate(
                                        offset: Offset(0, _titleSlideAnimation.value),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Explore New Fashion',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      letterSpacing: -0.5,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                AnimatedBuilder(
                                  animation: _contentController,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _subtitleFadeAnimation.value,
                                      child: Transform.translate(
                                        offset: Offset(0, _subtitleSlideAnimation.value),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Virtually try on thousands of outfits and discover your perfect style from the comfort of your home.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      height: 1.6,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                AnimatedBuilder(
                                  animation: _buttonController,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _buttonFadeAnimation.value,
                                      child: Transform.scale(
                                        scale: _buttonScaleAnimation.value,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: _buildAnimatedButton(),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Transition effects overlay - Gold themed instead of white
              if (_isTransitioning) ...[
                // Gold glowing background
                IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _goldGlowAnimation,
                    builder: (context, _) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(size.width / 2, size.height * 0.8),
                            radius: _goldGlowAnimation.value * 1.2,
                            colors: [
                              const Color(0xFFC8A96E).withOpacity(0.4),
                              const Color(0xFFD4AF37).withOpacity(0.2),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Gold wave rings expanding from button
                IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _goldWaveAnimation,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _GoldWavePainter(
                          progress: _goldWaveAnimation.value,
                          size: size,
                        ),
                        child: const SizedBox.expand(),
                      );
                    },
                  ),
                ),
                
                // Golden particle burst effect
                IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _particleAnimation,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _GoldenParticlePainter(
                          progress: _particleAnimation.value,
                          size: size,
                        ),
                        child: const SizedBox.expand(),
                      );
                    },
                  ),
                ),
                
                // Sparkle effects
                IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _transitionController,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _SparklePainter(
                          progress: _transitionController.value,
                          size: size,
                        ),
                        child: const SizedBox.expand(),
                      );
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, _) {
        return Stack(
          children: [
            Positioned(
              top: 20 - _floatingAnimation.value * 0.3,
              left: 30,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE8DDD0).withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: 30 + _floatingAnimation.value * 0.4,
              right: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD4C5B0).withOpacity(0.4),
                ),
              ),
            ),
            Positioned(
              top: 60 + _floatingAnimation.value * 0.2,
              right: 40,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFC8B89A).withOpacity(0.35),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhoneMockup(Size size) {
    return Container(
      width: size.width * 0.58,
      height: size.height * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            blurRadius: 40,
            offset: const Offset(0, 16),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Stack(
          children: [
            Image.asset(
              'assets/onboardingimage.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFF0EAE0),
                  child: const Center(
                    child: Icon(
                      Icons.checkroom_rounded,
                      size: 64,
                      color: Color(0xFFB0A090),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _shimmerController,
              builder: (context, _) {
                return Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(
                            -1.5 + _shimmerAnimation.value * 1.5,
                            -0.5,
                          ),
                          end: Alignment(
                            -0.5 + _shimmerAnimation.value * 1.5,
                            0.5,
                          ),
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.07),
                            Colors.white.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return _PressableButton(
      onTap: _handleLetsGoTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: const Color(0xFFC8A96E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC8A96E).withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Let's Go",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

// Gold wave rings painter
class _GoldWavePainter extends CustomPainter {
  final double progress;
  final Size size;

  _GoldWavePainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final origin = Offset(size.width / 2, size.height * 0.82);
    
    // Draw multiple expanding gold rings
    for (int i = 0; i < 3; i++) {
      final ringProgress = (progress - i * 0.25).clamp(0.0, 1.0);
      final radius = 50 + (size.width * 0.8 * ringProgress);
      final opacity = (1 - ringProgress) * 0.6;
      final strokeWidth = 3.0 * (1 - ringProgress);
      
      if (opacity > 0) {
        final paint = Paint()
          ..color = const Color(0xFFD4AF37).withOpacity(opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;
        
        canvas.drawCircle(origin, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GoldWavePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Golden particle painter
class _GoldenParticlePainter extends CustomPainter {
  final double progress;
  final Size size;

  _GoldenParticlePainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final origin = Offset(size.width / 2, size.height * 0.82);
    
    // Create golden particles that burst outward
    for (int i = 0; i < 40; i++) {
      final angle = (i * 9) * (pi / 180);
      final distance = 250 * progress * (0.3 + (i % 7) * 0.1);
      final x = origin.dx + (distance * cos(angle + progress * 2));
      final y = origin.dy + (distance * sin(angle + progress * 1.5));
      
      final particleSize = (10.0 * (1 - progress)) * (0.2 + (i % 4) * 0.15);
      final opacity = (1 - progress) * 0.7 - (i % 6) * 0.03;
      
      if (opacity > 0 && particleSize > 0) {
        // Mix of gold and bronze colors
        final colors = [
          const Color(0xFFD4AF37), // Gold
          const Color(0xFFC8A96E), // Light gold
          const Color(0xFFB8860B), // Dark goldenrod
          const Color(0xFFDAA520), // Goldenrod
        ];
        
        final paint = Paint()
          ..color = colors[i % colors.length].withOpacity(opacity)
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(Offset(x, y), particleSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GoldenParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Sparkle painter for magical effect
class _SparklePainter extends CustomPainter {
  final double progress;
  final Size size;

  _SparklePainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final origin = Offset(size.width / 2, size.height * 0.82);
    
    // Create sparkle stars
    for (int i = 0; i < 25; i++) {
      final angle = (i * 14.4) * (pi / 180);
      final distance = 180 * progress * (0.5 + (i % 5) * 0.15);
      final x = origin.dx + (distance * cos(angle + progress * 3));
      final y = origin.dy + (distance * sin(angle + progress * 2));
      
      final sparkleSize = (6.0 * (1 - progress)) * (0.4 + (i % 3) * 0.2);
      final sparkleOpacity = (1 - progress) * 0.9;
      
      if (sparkleOpacity > 0 && sparkleSize > 2) {
        final paint = Paint()
          ..color = Colors.white.withOpacity(sparkleOpacity)
          ..style = PaintingStyle.fill;
        
        // Draw star-like shapes (4-point star)
        final path = Path();
        for (int j = 0; j < 8; j++) {
          final rad = pi / 4 * j;
          final r = j.isEven ? sparkleSize : sparkleSize * 0.4;
          final px = x + r * cos(rad);
          final py = y + r * sin(rad);
          if (j == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SparklePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Pressable button with scale feedback
class _PressableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PressableButton({required this.child, required this.onTap});

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}