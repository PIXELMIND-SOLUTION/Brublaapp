// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BrublaverseSection extends StatefulWidget {
  const BrublaverseSection({super.key});

  @override
  State<BrublaverseSection> createState() => _BrublaverseSectionState();
}

class _BrublaverseSectionState extends State<BrublaverseSection> {
  int _currentBrublaIndex = 0;

  final List<Map<String, dynamic>> _brublaverse = const [
    {'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b'},
    {'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f'},
    {'image': 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c'},
    {'image': 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: 'Explore The '),
                TextSpan(
                  text: 'Brublaverse',
                  style: TextStyle(decorationThickness: 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          CarouselSlider(
            options: CarouselOptions(
              height: 110,
              viewportFraction: 0.28,
              enableInfiniteScroll: true,
              autoPlay: false,
              onPageChanged: (i, _) => setState(() => _currentBrublaIndex = i),
            ),
            items: _brublaverse.map((item) => _brublaCard(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _brublaCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        item['image'],
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey.shade200,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
      ),
    );
  }
}