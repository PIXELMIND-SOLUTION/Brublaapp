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

  late AnimationController _transitionController;

  late Animation<double> _phoneSlideAnimation;
  late Animation<double> _phoneScaleAnimation;
  late Animation<double> _phoneFadeAnimation;

  late Animation<double> _titleSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _subtitleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;

  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _buttonFadeAnimation;

  late Animation<double> _floatingAnimation;

  late Animation<double> _shimmerAnimation;

  late Animation<double> _particleAnimation;
  late Animation<double> _goldWaveAnimation;
  late Animation<double> _pageFadeOutAnimation;
  late Animation<Offset> _slideOutAnimation;
  late Animation<double> _goldGlowAnimation;

  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();

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

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _transitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.elasticOut,
      ),
    );

    _goldWaveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.easeOutCubic,
      ),
    );

    _goldGlowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutQuad),
      ),
    );

    _pageFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
    _slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.2, 0),
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInCubic),
      ),
    );
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

    _floatingController.stop();
    _shimmerController.stop();

    await _transitionController.forward();

    if (!mounted) return;

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
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      body: AnimatedBuilder(
        animation: _transitionController,
        builder: (context, _) {
          return Stack(
            children: [
              Transform.translate(
                offset: _slideOutAnimation.value * Offset(size.width, 0).dx,
                child: Opacity(
                  opacity: _pageFadeOutAnimation.value,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: double.infinity,
                            color: const Color(0xFFF5F0EA),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _buildDecorativeCircles(),
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

                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            ),
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
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (_isTransitioning) ...[
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
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              'assets/themeimage.png',
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
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.35),
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

class _GoldWavePainter extends CustomPainter {
  final double progress;
  final Size size;

  _GoldWavePainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final origin = Offset(size.width / 2, size.height * 0.82);
    
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

class _GoldenParticlePainter extends CustomPainter {
  final double progress;
  final Size size;

  _GoldenParticlePainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final origin = Offset(size.width / 2, size.height * 0.82);
    
    for (int i = 0; i < 40; i++) {
      final angle = (i * 9) * (pi / 180);
      final distance = 250 * progress * (0.3 + (i % 7) * 0.1);
      final x = origin.dx + (distance * cos(angle + progress * 2));
      final y = origin.dy + (distance * sin(angle + progress * 1.5));
      
      final particleSize = (10.0 * (1 - progress)) * (0.2 + (i % 4) * 0.15);
      final opacity = (1 - progress) * 0.7 - (i % 6) * 0.03;
      
      if (opacity > 0 && particleSize > 0) {
        final colors = [
          const Color(0xFFD4AF37), 
          const Color(0xFFC8A96E),
          const Color(0xFFB8860B), 
          const Color(0xFFDAA520), 
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

class _SparklePainter extends CustomPainter {
  final double progress;
  final Size size;

  _SparklePainter({required this.progress, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final origin = Offset(size.width / 2, size.height * 0.82);
    
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