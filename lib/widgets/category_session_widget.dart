import 'package:flutter/material.dart';
import 'package:brublaapp/views/category/category_screen.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'image': 'assets/whiteshirt.png', 'label': 'Shirts'},
    {'image': 'assets/whitepant.png', 'label': 'Jeans for men'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _sectionHeader(
            'Category',
            context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: _categories
                .map(
                  (cat) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _categoryChip(cat),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, BuildContext context, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'View all >>',
            style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ],
    );
  }

  Widget _categoryChip(Map<String, dynamic> cat) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Image.asset(
            cat['image'],
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          cat['label'] as String,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}