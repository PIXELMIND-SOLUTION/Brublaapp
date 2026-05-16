import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentBannerIndex = 0;
  final CarouselSliderController _bannerController = CarouselSliderController();

  List<Map<String, dynamic>> _banners = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  Future<void> _fetchBanners() async {
    try {
      final response = await http.get(
        Uri.parse('http://31.97.228.17:4077/api/admin/banners'),
        headers: {'Content-Type': 'application/json'},
      );

      print(
        '📡 Response status code for get all banners ${response.statusCode}',
      );
      print(
        '🎯 Response boooooooooodddddddddyyyyyyyyyyyyy for get all banners ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List banners = data['banners'] ?? [];

        final activeBanners = banners
            .where((b) => b['isActive'] == true)
            .map<Map<String, dynamic>>(
              (b) => {'image': b['image'] as String, 'id': b['_id'] as String},
            )
            .toList();

        setState(() {
          _banners = activeBanners;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load banners (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: 180,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(height: 8),
              Text(_error!, style: const TextStyle(color: Colors.red)),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _fetchBanners();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_banners.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(child: Text('No banners available')),
      );
    }

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
            child: Image.network(
              banner['image'] as String,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
