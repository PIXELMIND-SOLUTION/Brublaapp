import 'package:flutter/material.dart';

class SingleDetailScreen extends StatefulWidget {
  const SingleDetailScreen({super.key});

  @override
  State<SingleDetailScreen> createState() => _SingleDetailScreenState();
}

class _SingleDetailScreenState extends State<SingleDetailScreen> {
  String selectedSize = 'X';
  int _selectedTab = 0;
  int _selectedImageIndex = 0;

  // Replace these with your actual asset paths
  final List<String> _productImages = [
    'assets/orderimage.png',
    'assets/detailscreenimage.png',
    'assets/homecard.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero Image Section ──
              _buildHeroSection(context),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    _buildTitlePrice(),
                    const SizedBox(height: 14),
                    _buildSizeSelector(),
                    const SizedBox(height: 14),
                    _buildDesignerSection(),
                    const SizedBox(height: 10),
                    _buildDeliveryBanner(),
                    const SizedBox(height: 14),
                    _buildDeliveryDetails(),
                    const SizedBox(height: 14),
                    _buildDescriptionTabs(),
                    const SizedBox(height: 10),
                    if (_selectedTab == 0) _buildDescriptionText(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              _buildActionButtons(),
              const SizedBox(height: 20),
              _buildSectionHeader('Designer Products'),
              _buildProductGrid(),
              const SizedBox(height: 16),
              _buildSectionHeader('Related Products'),
              _buildRelatedProductsRow(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Hero Section  (thumbnails at bottom-center)
  // ─────────────────────────────────────────────
  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      children: [
        // ── Main large image ──
        Container(
          width: double.infinity,
          height: 300,
          color: const Color(0xFFF5EFE6),
          child: Image.asset(
            _productImages[_selectedImageIndex],
            fit: BoxFit.cover,
          ),
        ),

        // ── Dark gradient at the bottom so thumbnails are readable ──
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 90,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0x88000000), Colors.transparent],
              ),
            ),
          ),
        ),

        // ── Back button ──
        Positioned(
          top: 12,
          left: 12,
          child: GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        // ── Thumbnail strip — bottom center ──
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_productImages.length, (i) {
              final isSelected = _selectedImageIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _selectedImageIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 56,
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFB8860B)
                          : Colors.white.withOpacity(0.6),
                      width: isSelected ? 2.5 : 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFB8860B).withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(_productImages[i], fit: BoxFit.cover),
                  ),
                ),
              );
            }),
          ),
        ),

        // ── Dot indicators ──
        Positioned(
          bottom: -2,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_productImages.length, (i) {
              final isSelected = _selectedImageIndex == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                width: isSelected ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFB8860B)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  Title + Price
  // ─────────────────────────────────────────────
  Widget _buildTitlePrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tommy Shirts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '\$ 5000/-',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              '\$ 9000/-',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  Size Selector
  // ─────────────────────────────────────────────
  Widget _buildSizeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Size',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: ['X', 'XL'].map((size) {
                final isSelected = selectedSize == size;
                return GestureDetector(
                  onTap: () => setState(() => selectedSize = size),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2C2C2C)
                          : Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2C2C2C)
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Size Guide',
            style: TextStyle(color: Color(0xFFB8860B), fontSize: 13),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  Designer Section
  // ─────────────────────────────────────────────
  Widget _buildDesignerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Designer',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5EFE6),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ClipOval(
                child: Image.asset('assets/homecard.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Brubla Orginal',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'New Profile',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  Free Delivery Banner
  // ─────────────────────────────────────────────
  Widget _buildDeliveryBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3CD), Color(0xFFFFE082)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subscribe Now To Get A Free Delivery',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5D4037),
                  ),
                ),
                Text(
                  'For Next Five Orders',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Color(0xFF5D4037),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Delivery Details
  // ─────────────────────────────────────────────
  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery  Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Color(0xFFB8860B),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Hyderabad, Telangana, Kukatpally, Kphb colony, 500072. Delivery on 20 August',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.add, size: 14, color: Color(0xFFB8860B)),
            const SizedBox(width: 4),
            const Text(
              'ADD NEW ADDRESS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFB8860B),
              ),
            ),
            const Spacer(),
            Text(
              'View All >>',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionTabs() {
    return Row(
      children: [
        _tabItem('Description', 0),
        const SizedBox(width: 20),
        _tabItem('Reviews', 1),
      ],
    );
  }

  Widget _tabItem(String label, int index) {
    final isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
              color: isActive ? Colors.black87 : Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 4),
          if (isActive)
            Container(
              height: 2,
              width: label.length * 7.5,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Description Text
  // ─────────────────────────────────────────────
  Widget _buildDescriptionText() {
    return Text(
      'Explore a wide range of high-quality products tailored to meet your everyday needs. Our e-commerce platform offers a seamless shopping experience with secure payments, fast delivery, and easy returns. Discover trending items, exclusive deals, and personalized recommendations—all in one place.',
      style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.55),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  // ─────────────────────────────────────────────
  //  Action Buttons
  // ─────────────────────────────────────────────
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8860B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Buy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Section Header
  // ─────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            'View All',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Designer Products (2×2 Grid)
  // ─────────────────────────────────────────────
  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _productCard()),
              const SizedBox(width: 12),
              Expanded(child: _productCard()),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _productCard()),
              const SizedBox(width: 12),
              Expanded(child: _productCard()),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Related Products Row
  // ─────────────────────────────────────────────
  Widget _buildRelatedProductsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          2,
          (_) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _productCard(),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Reusable Product Card
  // ─────────────────────────────────────────────
  Widget _productCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Container(
                width: double.infinity,
                color: const Color(0xFFF5EFE6),
                child: Image.asset('assets/homecard.png', fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tommy Shirts',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '\$ 200/-',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB8860B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
