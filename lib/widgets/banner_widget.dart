import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentBannerIndex = 0;
  final CarouselSliderController _bannerController = CarouselSliderController();

  final List<Map<String, dynamic>> _banners = const [
    {
      'title': 'D ENING ION STORE',
      'subtitle': 'TEST MEN\'S FASHION TRENDS',
      'image': 'assets/banner.png',
    },
    {
      'title': 'GRAND OPENING FASHION STORE',
      'subtitle': 'DISCOVER THE LATEST MEN\'S FASHION TRENDS',
      'image': 'assets/banner.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _bannerController,
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, _) =>
                setState(() => _currentBannerIndex = index),
          ),
          items: _banners.map((banner) => _bannerCard(banner)).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBannerIndex == i ? 18 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: _currentBannerIndex == i
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 174, 174, 174),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bannerCard(Map<String, dynamic> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              banner['image'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),
          Positioned(
            right: 24,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'GET IT\nNOW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}