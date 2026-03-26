import 'package:brublaapp/views/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _subtitleController;
  late AnimationController _shimmerController;
  late AnimationController _particleController;
  late AnimationController _bgController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _logoBounce;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _subtitleFade;
  late Animation<double> _subtitleLetterSpacing;
  late Animation<double> _shimmerAnim;
  late Animation<double> _particleAnim;
  late Animation<Color?> _bgColorAnim;
  late Animation<double> _exitScale;
  late Animation<double> _exitFade;

  bool _isExiting = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _subtitleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bgController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Logo animations
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack)),
    );
    _logoBounce = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.7, 1.0, curve: Curves.elasticOut)),
    );

    // Text animations
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // Subtitle animations
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeOut),
    );
    _subtitleLetterSpacing = Tween<double>(begin: 1.0, end: 6.0).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeOutCubic),
    );

    // Shimmer
    _shimmerAnim = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Particles
    _particleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.easeOut),
    );

    // Background
    _bgColorAnim = ColorTween(
      begin: const Color(0xFFF0EBE3),
      end: const Color(0xFFE8E0D5),
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));

    // Exit animations
    _exitScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeIn),
    );
    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _bgController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));

    _logoController.forward();
    _particleController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 350));
    _subtitleController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _shimmerController.forward();

    // Wait for everything to settle, then exit
    await Future.delayed(const Duration(milliseconds: 1200));
    _triggerExit();
  }

  Future<void> _triggerExit() async {
    if (!mounted) return;
    setState(() => _isExiting = true);
    _bgController.forward();

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _subtitleController.dispose();
    _shimmerController.dispose();
    _particleController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _logoController,
        _textController,
        _subtitleController,
        _shimmerController,
        _particleController,
        _bgController,
      ]),
      builder: (context, _) {
        return Scaffold(
          backgroundColor: _bgColorAnim.value ?? const Color(0xFFF0EBE3),
          body: Stack(
            children: [
              // Soft radial glow background
              Positioned.fill(
                child: Opacity(
                  opacity: _logoFade.value * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.8,
                        colors: [
                          const Color(0xFFD4C5B2).withOpacity(0.6),
                          const Color(0xFFF0EBE3).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Floating particles
              ..._buildParticles(),

              // Main content
              Center(
                child: Opacity(
                  opacity: _isExiting ? _exitFade.value : 1.0,
                  child: Transform.scale(
                    scale: _isExiting ? _exitScale.value : 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with glow ring
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow ring
                            Opacity(
                              opacity: _logoFade.value * 0.35,
                              child: Container(
                                width: 210,
                                height: 210,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFB8A99A)
                                          .withOpacity(0.6),
                                      blurRadius: 50,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Logo
                            Opacity(
                              opacity: _logoFade.value,
                              child: Transform.scale(
                                scale: _logoScale.value * _logoBounce.value,
                                child: Image.asset(
                                  'assets/logo.png',
                                  width: 170,
                                  height: 170,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // Brand name with shimmer
                        SlideTransition(
                          position: _textSlide,
                          child: Opacity(
                            opacity: _textFade.value,
                            child: _buildShimmerText(
                              'YourBrand',
                              const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3B2F2F),
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle with expanding letter spacing
                        Opacity(
                          opacity: _subtitleFade.value,
                          child: Text(
                            'DISCOVER  ·  EXPLORE  ·  ENJOY',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF8B7B6B),
                              letterSpacing: _subtitleLetterSpacing.value,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Loading dots
                        Opacity(
                          opacity: _subtitleFade.value,
                          child: _buildLoadingDots(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Shimmer sweep over text using a ShaderMask
  Widget _buildShimmerText(String text, TextStyle style) {
    return ShaderMask(
      shaderCallback: (bounds) {
        final shimmerX = _shimmerAnim.value;
        return LinearGradient(
          begin: Alignment(shimmerX - 0.4, 0),
          end: Alignment(shimmerX + 0.4, 0),
          colors: const [
            Color(0xFF3B2F2F),
            Color(0xFFD4C5B2),
            Color(0xFF3B2F2F),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }

  /// Animated pulsing dots
  Widget _buildLoadingDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _particleController,
          builder: (context, _) {
            final delay = i * 0.25;
            final t = ((_particleController.value - delay) % 1.0).clamp(0.0, 1.0);
            final scale = 0.6 + 0.6 * (t < 0.5 ? t * 2 : (1.0 - t) * 2);
            final opacity = 0.3 + 0.7 * (t < 0.5 ? t * 2 : (1.0 - t) * 2);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8B7B6B),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  /// Floating ambient particles
  List<Widget> _buildParticles() {
    final particles = [
      _ParticleData(left: 0.1, top: 0.15, size: 6, delay: 0.0, opacity: 0.4),
      _ParticleData(left: 0.85, top: 0.2, size: 8, delay: 0.1, opacity: 0.3),
      _ParticleData(left: 0.2, top: 0.75, size: 5, delay: 0.2, opacity: 0.35),
      _ParticleData(left: 0.78, top: 0.7, size: 7, delay: 0.15, opacity: 0.3),
      _ParticleData(left: 0.5, top: 0.1, size: 4, delay: 0.3, opacity: 0.25),
      _ParticleData(left: 0.05, top: 0.5, size: 5, delay: 0.05, opacity: 0.2),
      _ParticleData(left: 0.92, top: 0.45, size: 6, delay: 0.25, opacity: 0.25),
    ];

    return particles.map((p) {
      return AnimatedBuilder(
        animation: _particleController,
        builder: (context, _) {
          final screen = MediaQuery.of(context).size;
          final t = ((_particleController.value - p.delay).clamp(0.0, 1.0));
          final floatY = -12.0 * t;
          final opacity = p.opacity * _logoFade.value * (1.0 - t * 0.3);

          return Positioned(
            left: p.left * screen.width,
            top: p.top * screen.height + floatY,
            child: Opacity(
              opacity: opacity.clamp(0.0, 1.0),
              child: Container(
                width: p.size,
                height: p.size,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8A99A),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB8A99A).withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }
}

class _ParticleData {
  final double left, top, size, delay, opacity;
  const _ParticleData({
    required this.left,
    required this.top,
    required this.size,
    required this.delay,
    required this.opacity,
  });
}

// ─── Placeholder OnboardingScreen ───────────────────────────────────────────
