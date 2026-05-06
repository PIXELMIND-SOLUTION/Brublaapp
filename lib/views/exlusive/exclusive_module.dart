// ignore_for_file: unused_field

import 'package:brublaapp/views/address/address_screen.dart';
import 'package:brublaapp/views/cart/cart_screen.dart';
import 'package:brublaapp/views/category/category_screen.dart';
import 'package:brublaapp/views/details/exclusive_details.dart';
import 'package:brublaapp/views/notifications/notification_screen.dart';
import 'package:brublaapp/views/profile/profile_screen.dart';
import 'package:brublaapp/views/wallet/wallet_screen.dart';
import 'package:brublaapp/views/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExclusiveModule extends StatefulWidget {
  const ExclusiveModule({super.key});

  @override
  State<ExclusiveModule> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ExclusiveModule> {
  final List<String> _searchHints = ['Shirts', 'Pants', 'Shorts', 'Kurtas'];

  int _currentHintIndex = 0;
  int _currentBannerIndex = 0;
  int _currentBrublaIndex = 0;
  final CarouselSliderController _bannerController = CarouselSliderController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _startHintRotation();
    });
  }

  void _startHintRotation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return false;

      setState(() {
        _currentHintIndex = (_currentHintIndex + 1) % _searchHints.length;
      });

      return true;
    });
  }

  final List<Map<String, dynamic>> _brublaverse = [
    {'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b'},
    {'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f'},
    {'image': 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c'},
    {'image': 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'image': 'assets/shirtimage.png', 'label': 'Shirts'},
    {'image': 'assets/jeansimage.png', 'label': 'Jeans for men'},
  ];

  final List<Map<String, dynamic>> _banners = [
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

  final List<Map<String, dynamic>> _latestDesigns = [
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'selected': true,
    },
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'selected': false,
    },
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'selected': false,
    },
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'selected': false,
    },
  ];

  final List<Map<String, dynamic>> _mostSales = [
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'discount': '20% off',
      'rating': '4.5/5',
    },
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'discount': '20% off',
      'rating': '4.5/5',
    },
  ];

  final List<Map<String, dynamic>> _recommended = [
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
    },
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              _buildSearchBar(),
              _buildCategoryTabs(),
              _buildCategorySection(),
              _buildBannerCarousel(),
              _buildSectionWithGrid(
                title: 'Recently Viewed',

                items: _latestDesigns,
                showSelected: true,
                onViewAllTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ExclusiveDetails()),
                  );
                },
              ),
              _buildRecommendedRow(),
              _buildBrublaverseSection(),
              _buildUpcomingDropSection(),
              _buildMostSalesSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ── TOP BAR ──────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              radius: 22,
              backgroundImage: const AssetImage('assets/profile.png'),
              backgroundColor: Colors.grey.shade200,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'PMS',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    size: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '1200',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressScreen()),
              );
            },
            child: _iconButton(Icons.location_on_outlined),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            child: _iconButton(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Icon(
        icon,
        size: 18,
        color: const Color.fromARGB(221, 255, 255, 255),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 14),

                // decoration: InputDecoration(
                //   isCollapsed: true, // ⭐ KEY FIX
                //   // hintText: 'Search for "Shirts"',

                //   hintText: 'Search for "${_searchHints[_currentHintIndex]}"',
                //   hintStyle: TextStyle(
                //     fontSize: 13,
                //     color: Colors.grey.shade500,
                //   ),
                //   prefixIcon: Icon(
                //     Icons.search,
                //     size: 20,
                //     color: Colors.grey.shade500,
                //   ),
                //   prefixIconConstraints: const BoxConstraints(
                //     minWidth: 40,
                //     minHeight: 40,
                //   ),
                //   border: InputBorder.none,
                //   contentPadding: const EdgeInsets.symmetric(
                //     vertical: 12, // ⭐ balances text perfectly
                //   ),
                // ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hint: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Search for ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        TextSpan(
                          text: '"${_searchHints[_currentHintIndex]}"',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black, // 👈 ONLY this part is black
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.grey.shade500,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistScreen()),
              );
            },
            child: _searchActionButton(Icons.favorite_border),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            child: _searchActionButton(Icons.shopping_cart_outlined),
          ),
        ],
      ),
    );
  }

  Widget _searchActionButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }

  // ── CATEGORY TABS ────────────────────────────────────────────────────────
  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _tabItem('All', true),
          const SizedBox(width: 16),
          _tabItem('Men', false),
          const SizedBox(width: 16),
          _tabItem('Women', false),
        ],
      ),
    );
  }

  Widget _tabItem(String text, bool active) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: active ? FontWeight.bold : FontWeight.normal,
        color: active ? Color.fromARGB(255, 255, 255, 255) : Colors.grey,
        decoration: active ? TextDecoration.none : TextDecoration.none,
      ),
    );
  }

  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _sectionHeader(
            'Category',
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

  Widget _categoryChip(Map<String, dynamic> cat) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(12), // spacing inside box
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Image.asset(cat['image'], fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        Text(
          cat['label'] as String,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // ── BANNER CAROUSEL ───────────────────────────────────────────────────────
  Widget _buildBannerCarousel() {
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
                    ? Colors.orange
                    : Colors.grey.shade300,
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
          // Background image
          Positioned.fill(
            child: Image.asset(
              banner['image'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),
          // GET IT NOW badge
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
                    color: Colors.white,
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

  // ── SECTION GRID (Latest Designs) ────────────────────────────────────────
  Widget _buildSectionWithGrid({
    required String title,
    required List<Map<String, dynamic>> items,
    bool showSelected = false,
    VoidCallback? onViewAllTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _sectionHeader(title, onTap: onViewAllTap),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExclusiveDetails()),
                );
              },
              child: _productCard(
                items[i],
                showBorder: showSelected && items[i]['selected'] == true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(Map<String, dynamic> item, {bool showBorder = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: showBorder
            ? Border.all(color: Colors.orange, width: 2)
            : Border.all(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Product image
          Positioned.fill(
            child: Image.asset(
              item['image'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),
          // Discount badge if present
          if (item['discount'] != null)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item['discount'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // Bottom info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item['price'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['original'] as String,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  if (item['rating'] != null)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          item['rating'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── RECOMMENDED ROW ───────────────────────────────────────────────────────
  Widget _buildRecommendedRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          _sectionHeader('Designers in the spot'),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _recommended.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) =>
                  SizedBox(width: 140, child: _productCard(_recommended[i])),
            ),
          ),
        ],
      ),
    );
  }

  // ── BRUBLAVERSE SECTION ───────────────────────────────────────────────────
  Widget _buildBrublaverseSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'Explore The ',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Brublaverse',
                  style: TextStyle(decorationThickness: 2, color: Colors.white),
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

  // ── UPCOMING DROP ─────────────────────────────────────────────────────────
  Widget _buildUpcomingDropSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          _sectionHeader('Upcoming Drop'),
          const SizedBox(height: 10),
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/banner.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.grey.shade200),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'GRAND\nOPENING\nFASHION STORE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'DISCOVER THE LATEST MEN\'S FASHION TRENDS',
                        style: TextStyle(fontSize: 8, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'GET IT\nNOW',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── MOST SALES ────────────────────────────────────────────────────────────
  Widget _buildMostSalesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          _sectionHeader('Designers on Discount'),
          const SizedBox(height: 12),
          Row(
            children: _mostSales
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AspectRatio(
                        aspectRatio: 0.78,
                        child: _productCard(item),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        GestureDetector(
          onTap: onTap, // 👈 dynamic action
          child: const Text(
            'View all >>',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }
}
