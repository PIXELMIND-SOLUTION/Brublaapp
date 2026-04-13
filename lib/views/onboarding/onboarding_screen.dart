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

  @override
  void dispose() {
    _phoneController.dispose();
    _contentController.dispose();
    _buttonController.dispose();
    _floatingController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),

      body: SafeArea(
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
                    // Decorative background circles
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
                    // Title
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

                    // Subtitle
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

                    // CTA Button
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

                    // Page indicator dots
                    // AnimatedBuilder(
                    //   animation: _buttonController,
                    //   builder: (context, child) {
                    //     return Opacity(
                    //       opacity: _buttonFadeAnimation.value,
                    //       child: child,
                    //     );
                    //   },
                    //   child: _buildPageIndicators(),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            // Only the fashion image
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
            // Shimmer overlay
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
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
      },
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