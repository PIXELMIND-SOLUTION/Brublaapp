// lib/views/Designermodule/navbar/navbar_screen.dart

import 'dart:ui';
import 'package:brublaapp/provider/dessigner/designer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignerNavbarScreen extends StatelessWidget {
  const DesignerNavbarScreen({super.key});

  static const List<Widget> _pages = [
    Placeholder(),
    Placeholder(), 
    Placeholder(), 
  ];

  @override
  Widget build(BuildContext context) {
    final navbarProvider = context.watch<DesignerNavbarProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      extendBody: true,
      body: _pages[navbarProvider.currentIndex],
      bottomNavigationBar: _DesignerNavBar(
        currentIndex: navbarProvider.currentIndex,
        onTap: navbarProvider.setIndex,
      ),
    );
  }
}

class _DesignerNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _DesignerNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(
        icon: Icons.palette_outlined,
        activeIcon: Icons.palette_rounded,
        label: 'Studio'),
    _NavItem(
        icon: Icons.history_outlined,
        activeIcon: Icons.history_rounded,
        label: 'History'),
    _NavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person_rounded,
        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCFB896).withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 73,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF3EC).withOpacity(0.96),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFCFB896).withOpacity(0.35),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_items.length, (index) {
                  return _DesignerNavItem(
                    item: _items[index],
                    isSelected: currentIndex == index,
                    onTap: () => onTap(index),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesignerNavItem extends StatefulWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _DesignerNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_DesignerNavItem> createState() => _DesignerNavItemState();
}

class _DesignerNavItemState extends State<_DesignerNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  static const Color _tan = Color(0xFFCFB896);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    if (widget.isSelected) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant _DesignerNavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward(from: 0);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (widget.isSelected) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: _tan,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: _tan.withOpacity(0.4),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.item.activeIcon,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          widget.item.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.item.icon,
                    size: 24,
                    color: const Color(0xFFAA9070),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.label,
                    style: const TextStyle(
                      color: Color(0xFFAA9070),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}