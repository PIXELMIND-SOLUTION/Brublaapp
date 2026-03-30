import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen>
    with TickerProviderStateMixin {
  final TextEditingController _couponController = TextEditingController();
  late AnimationController _shakeController;
  late AnimationController _successController;
  late Animation<double> _shakeAnimation;
  late Animation<double> _successAnimation;

  String? _appliedCoupon;
  bool _isLoading = false;

  final List<CouponModel> _availableCoupons = [
    CouponModel(
      code: 'SAVE20',
      title: '20% Off Sitewide',
      description: 'Get 20% off on all products',
      discount: '20%',
      expiry: 'Dec 31, 2025',
      minOrder: '₹499',
      color: const Color(0xFFFF6B35),
      icon: Icons.percent_rounded,
      type: CouponType.percentage,
    ),
    CouponModel(
      code: 'FLAT150',
      title: 'Flat ₹150 Off',
      description: 'Flat discount on orders above ₹999',
      discount: '₹150',
      expiry: 'Nov 15, 2025',
      minOrder: '₹999',
      color: const Color(0xFF6C63FF),
      icon: Icons.currency_rupee_rounded,
      type: CouponType.flat,
    ),
    CouponModel(
      code: 'FREESHIP',
      title: 'Free Shipping',
      description: 'No delivery charges on your order',
      discount: 'FREE',
      expiry: 'Ongoing',
      minOrder: '₹299',
      color: const Color(0xFF00C896),
      icon: Icons.local_shipping_rounded,
      type: CouponType.shipping,
    ),
    // CouponModel(
    //   code: 'NEWUSER50',
    //   title: '₹50 for New Users',
    //   description: 'Exclusive offer for first-time shoppers',
    //   discount: '₹50',
    //   expiry: 'One-time use',
    //   minOrder: '₹199',
    //   color: const Color(0xFFE91E8C),
    //   icon: Icons.person_add_rounded,
    //   type: CouponType.flat,
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _successController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _successAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _successController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    _shakeController.dispose();
    _successController.dispose();
    super.dispose();
  }

  void _applyCoupon(String code) {
    final trimmed = code.trim().toUpperCase();
    final match = _availableCoupons.where((c) => c.code == trimmed).firstOrNull;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => _isLoading = false);

      if (match != null) {
        setState(() => _appliedCoupon = trimmed);
        _successController.forward(from: 0);
        _showSnackbar('🎉 Coupon applied successfully!', isSuccess: true);
      } else {
        _shakeController.forward(from: 0);
        _showSnackbar('🎉 Coupon applied successfully!.', isSuccess: false);
      }
    });
  }

  void _removeCoupon() {
    setState(() {
      _appliedCoupon = null;
      _couponController.clear();
    });
  }

  void _showSnackbar(String message, {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        backgroundColor: isSuccess
            ? const Color(0xFF00C896)
            : const Color(0xFFFF4757),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildCouponInputSection(),
                  if (_appliedCoupon != null) ...[
                    const SizedBox(height: 20),
                    _buildAppliedBanner(),
                  ],
                  const SizedBox(height: 32),
                  _buildSectionTitle('Available Offers'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCouponCard(_availableCoupons[index]),
                ),
                childCount: _availableCoupons.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 130,
      pinned: true,
      backgroundColor: const Color(0xFF1A1A2E),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupons & Offers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'Save more on every order',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            ),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Icon(
                Icons.confirmation_num_rounded,
                size: 60,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCouponInputSection() {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        final offset = (_shakeAnimation.value * 10) *
            ((_shakeController.value < 0.5) ? 1 : -1);
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Coupon Code',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F4EF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE0DDD8),
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: _couponController,
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                        letterSpacing: 2,
                      ),
                      decoration: InputDecoration(
                        hintText: 'e.g. SAVE20',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400,
                          letterSpacing: 1,
                        ),
                        prefixIcon: const Icon(
                          Icons.confirmation_num_outlined,
                          color: Color(0xFF6C63FF),
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () => _applyCoupon(_couponController.text),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 52,
                    width: 88,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF5A52E0)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppliedBanner() {
    final coupon = _availableCoupons
        .firstWhere((c) => c.code == _appliedCoupon);
    return ScaleTransition(
      scale: _successAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF00C896).withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF00C896).withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF00C896),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${coupon.code} Applied!',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: Color(0xFF00A87A),
                    ),
                  ),
                  Text(
                    'You save ${coupon.discount} on this order',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF00A87A),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _removeCoupon,
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF00A87A),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
            letterSpacing: -0.3,
          ),
        ),
        const Spacer(),
        Text(
          '${_availableCoupons.length} offers',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCouponCard(CouponModel coupon) {
    final isApplied = _appliedCoupon == coupon.code;

    return GestureDetector(
      onTap: () => _applyCoupon(coupon.code),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isApplied
              ? coupon.color.withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isApplied ? coupon.color : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isApplied
                  ? coupon.color.withOpacity(0.15)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left colored strip with icon
            Container(
              width: 88,
              decoration: BoxDecoration(
                color: coupon.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(coupon.icon, color: Colors.white, size: 28),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      coupon.discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Dashed divider
            _buildDashedDivider(coupon.color),

            // Right content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            coupon.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                        if (isApplied)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: coupon.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Applied',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coupon.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildBadge(
                          Icons.receipt_outlined,
                          'Min. ${coupon.minOrder}',
                          coupon.color,
                        ),
                        const SizedBox(width: 8),
                        _buildBadge(
                          Icons.access_time_rounded,
                          coupon.expiry,
                          Colors.grey.shade400,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: coupon.code));
                            _showSnackbar(
                                '${coupon.code} copied!',
                                isSuccess: true);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: coupon.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: coupon.color.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  coupon.code,
                                  style: TextStyle(
                                    color: coupon.color,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.copy_rounded,
                                  size: 12,
                                  color: coupon.color,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          isApplied ? 'Tap to remove' : 'Tap to apply',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                            fontStyle: FontStyle.italic,
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
      ),
    );
  }

  Widget _buildDashedDivider(Color color) {
    return SizedBox(
      width: 16,
      child: Column(
        children: [
          Container(
            width: 16,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
              height: 80,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const dashH = 5.0;
                  const gap = 4.0;
                  final count = (constraints.maxHeight / (dashH + gap)).floor();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      count,
                      (_) => Container(
                        width: 2,
                        height: dashH,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: 16,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_appliedCoupon != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Coupon Savings',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                Text(
                  '- ${_availableCoupons.firstWhere((c) => c.code == _appliedCoupon).discount}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00C896),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A2E),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                _appliedCoupon != null
                    ? 'Continue with $_appliedCoupon'
                    : 'Proceed to Checkout',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum CouponType { percentage, flat, shipping }

class CouponModel {
  final String code;
  final String title;
  final String description;
  final String discount;
  final String expiry;
  final String minOrder;
  final Color color;
  final IconData icon;
  final CouponType type;

  const CouponModel({
    required this.code,
    required this.title,
    required this.description,
    required this.discount,
    required this.expiry,
    required this.minOrder,
    required this.color,
    required this.icon,
    required this.type,
  });
}