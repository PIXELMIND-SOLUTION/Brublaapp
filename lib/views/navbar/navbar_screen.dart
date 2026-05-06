import 'package:brublaapp/views/exlusive/exclusive_module.dart';
import 'package:brublaapp/views/history/history_screen.dart';
import 'package:brublaapp/views/history/tailor_history_screen.dart';
import 'package:brublaapp/views/home/home_screen.dart';
import 'package:brublaapp/views/home/tailer_screen.dart';
import 'package:brublaapp/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

// ─── Provider ────────────────────────────────────────────────────────────────

class BottomNavbarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

// ─── Navbar Screen ────────────────────────────────────────────────────────────

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    ExclusiveModule(),

    TailorHistoryScreen(),
    // TailerScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: BrublaBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}

// ─── Curved Shape ─────────────────────────────────────────────────────────────

class _CurvedWithBumpShape extends CustomPainter {
  final Color bgColor;

  _CurvedWithBumpShape({required this.bgColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    // Soft drop shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final double cx = size.width / 2;
    const double bumpRadius = 38.0;
    const double bumpHeight = 28.0;

    final path = Path();

    // Start from top-left
    path.moveTo(0, bumpHeight);

    // Left flat section
    path.lineTo(cx - bumpRadius - 22, bumpHeight);

    // Smooth curve UP into the bump (left side)
    path.cubicTo(cx - bumpRadius - 6, bumpHeight, cx - bumpRadius, 0, cx, 0);

    path.cubicTo(
      cx + bumpRadius,
      0,
      cx + bumpRadius + 6,
      bumpHeight, // cp2
      cx + bumpRadius + 22,
      bumpHeight, // back to bar level
    );

    path.lineTo(size.width, bumpHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CurvedWithBumpShape old) => old.bgColor != bgColor;
}

// ─── Bottom Nav Bar ───────────────────────────────────────────────────────────

class BrublaBottomNavBar extends StatelessWidget {
  const BrublaBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const Color activeColor = Color(0xFFCCA882);
  static const Color inactiveColor = Color(0xFF9E9E9E);
  static const double bumpHeight = 28.0;
  static const double fabSize = 58.0;
  static const double barHeight = 68.0;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final totalHeight = barHeight + bumpHeight + bottom;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Curved painted background ──
          Positioned.fill(
            child: CustomPaint(
              painter: _CurvedWithBumpShape(bgColor: Colors.white),
            ),
          ),

          // ── Left + Right nav items (sit on the flat bar, not the bump) ──
          Positioned(
            left: 0,
            right: 0,
            bottom: bottom,
            height: barHeight,
            child: Row(
              children: [
                // Home
                Expanded(
                  child: _NavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                ),
                // Stylist
                Expanded(
                  child: _NavItem(
                    icon: Icons.search,
                    label: 'Stylist',
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                ),

                // Center gap — space for the bump + FAB
                const SizedBox(width: 120),

                // Tailer
                Expanded(
                  child: _NavItem(
                    icon: Icons.shopping_bag_outlined,
                    label: 'Tailer',
                    isActive: currentIndex == 3,
                    onTap: () => onTap(3),
                  ),
                ),
                // Profile
                Expanded(
                  child: _NavItem(
                    icon: Icons.more_vert,
                    label: 'Profile',
                    isActive: currentIndex == 4,
                    onTap: () => onTap(4),
                  ),
                ),
              ],
            ),
          ),

          // ── Center FAB sitting inside the bump ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: fabSize,
                      height: fabSize,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: activeColor.withOpacity(0.30),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Brubla Exclusive',
                      style: TextStyle(
                        fontSize: 10,
                        color: currentIndex == 2 ? activeColor : inactiveColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nav Item ─────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? const Color.fromARGB(255, 0, 0, 0)
        : const Color(0xFF9E9E9E);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
