import 'package:flutter/material.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int _selectedTab = 0; // 0: All, 1: Men, 2: Women

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _tabItem('All', _selectedTab == 0, () {
            setState(() => _selectedTab = 0);
          }),
          const SizedBox(width: 16),
          _tabItem('Men', _selectedTab == 1, () {
            setState(() => _selectedTab = 1);
          }),
          const SizedBox(width: 16),
          _tabItem('Women', _selectedTab == 2, () {
            setState(() => _selectedTab = 2);
          }),
        ],
      ),
    );
  }

  Widget _tabItem(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
        ),
      ),
    );
  }
}