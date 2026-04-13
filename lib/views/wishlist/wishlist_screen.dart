import 'package:brublaapp/views/details/single_detail_screen.dart';
import 'package:flutter/material.dart';

class WishlistItem {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final String category;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.category,
  });
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen>
    with TickerProviderStateMixin {
  late List<WishlistItem> _items;
  final Set<String> _removingIds = {};

  // Palette
  static const Color _bg = Color(0xFFFAF9F7);
  static const Color _ink = Color(0xFF1A1A2E);
  static const Color _accent = Color(0xFFB8860B);
  static const Color _rose = Color(0xFFE8D5C4);
  static const Color _muted = Color(0xFF8A8A8A);
 

  @override
  void initState() {
    super.initState();
    _items = [
      const WishlistItem(
        id: '1',
        name: 'Silk Drape Blouse',
        brand: 'Maison Elara',
        imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400&q=80',
        price: 189.00,
        originalPrice: 249.00,
        category: 'Tops',
      ),
      const WishlistItem(
        id: '2',
        name: 'Structured Leather Tote',
        brand: 'Valore Studio',
        imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&q=80',
        price: 425.00,
        category: 'Bags',
      ),
      const WishlistItem(
        id: '3',
        name: 'Merino Ribbed Pullover',
        brand: 'Nordvik',
        imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=400&q=80',
        price: 138.00,
        originalPrice: 175.00,
        category: 'Knitwear',
      ),
      const WishlistItem(
        id: '4',
        name: 'Wide-Leg Tailored Trouser',
        brand: 'Atelier Forme',
        imageUrl: 'https://images.unsplash.com/photo-1594938374182-a56a1b36a8de?w=400&q=80',
        price: 210.00,
        category: 'Bottoms',
      ),
      const WishlistItem(
        id: '5',
        name: 'Gold Vermeil Ear Cuff',
        brand: 'Aurore Fine',
        imageUrl: 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=400&q=80',
        price: 78.00,
        originalPrice: 95.00,
        category: 'Jewellery',
      ),
    ];
  }

  void _removeItem(String id) {
    setState(() => _removingIds.add(id));
    Future.delayed(const Duration(milliseconds: 350), () {
      setState(() {
        _items.removeWhere((item) => item.id == id);
        _removingIds.remove(id);
      });
    });
  }

  void _addToCart(WishlistItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item.name} added to cart',
          style: const TextStyle(
            fontFamily: 'Georgia',
            color: Color(0xFFFAF9F7),
            fontSize: 13,
          ),
        ),
        backgroundColor: _ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: _bg,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          if (_items.isEmpty)
            _buildEmptyState()
          else ...[
            _buildItemCount(),
            _buildWishlistItems(),
            _buildBottomPadding(),
          ],
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 110,
      pinned: true,
      backgroundColor: _bg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, size: 20, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color.fromARGB(255, 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 2,
                    color: _accent,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'MY',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 4,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Wishlist',
                style: TextStyle(
                  fontSize: 34,
                  fontFamily: 'Georgia',
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemCount() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
        child: Row(
          children: [
            Text(
              '${_items.length} ${_items.length == 1 ? 'item' : 'items'} saved',
              style: const TextStyle(
                fontSize: 13,
                color: _muted,
                letterSpacing: 0.3,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Sort & Filter',
                style: TextStyle(
                  fontSize: 13,
                  color: _ink,
                  decoration: TextDecoration.underline,
                  decorationColor: _accent,
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistItems() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = _items[index];
            final isRemoving = _removingIds.contains(item.id);
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isRemoving ? 0.0 : 1.0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: isRemoving ? const Offset(0.08, 0) : Offset.zero,
                child: _WishlistCard(
                  item: item,
                  onRemove: () => _removeItem(item.id),
                  onAddToCart: () => _addToCart(item),
                ),
              ),
            );
          },
          childCount: _items.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _rose.withOpacity(0.5),
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 36,
                color: _accent,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Nothing saved yet',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Georgia',
                color: _ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap the heart on any product\nto save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _muted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 36),
            _GoldButton(
              label: 'Start Shopping',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPadding() {
    return const SliverToBoxAdapter(child: SizedBox(height: 40));
  }
}

// ── Wishlist Card ─────────────────────────────────────────────────────────────

class _WishlistCard extends StatefulWidget {
  final WishlistItem item;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const _WishlistCard({
    required this.item,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  State<_WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<_WishlistCard>
    with SingleTickerProviderStateMixin {
  static const Color _ink = Color(0xFF1A1A2E);
  static const Color _accent = Color(0xFFB8860B);
  static const Color _muted = Color(0xFF8A8A8A);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _divider = Color(0xFFEEEBE6);
  static const Color _rose = Color(0xFFE8D5C4);

  late AnimationController _heartController;
  bool _isFavourited = true;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.85,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleFavourite() async {
    await _heartController.reverse();
    setState(() => _isFavourited = !_isFavourited);
    await _heartController.forward();
    if (!_isFavourited) {
      await Future.delayed(const Duration(milliseconds: 600));
      widget.onRemove();
    }
  }

  bool get _hasDiscount => widget.item.originalPrice != null;
  int get _discountPercent => _hasDiscount
      ? (((widget.item.originalPrice! - widget.item.price) /
                  widget.item.originalPrice!) *
              100)
          .round()
      : 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCardTop(),
          _buildCardBottom(),
        ],
      ),
    );
  }

  Widget _buildCardTop() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(width: 14),
          Expanded(child: _buildDetails()),
          _buildHeartButton(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleDetailScreen()));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.item.imageUrl,
              width: 100,
              height: 118,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 118,
                color: _rose.withOpacity(0.4),
                child: const Icon(Icons.image_outlined, color: _muted),
              ),
            ),
          ),
        ),
        if (_hasDiscount)
          Positioned(
            top: 6,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                '-$_discountPercent%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 2),
        Text(
          widget.item.brand.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            letterSpacing: 2.5,
            color: _accent,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.item.name,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Georgia',
            color: _ink,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: _rose.withOpacity(0.45),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.item.category,
            style: const TextStyle(
              fontSize: 10,
              color: _ink,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '£${widget.item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Georgia',
                color: _ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (_hasDiscount) ...[
              const SizedBox(width: 8),
              Text(
                '£${widget.item.originalPrice!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 13,
                  color: _muted,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildHeartButton() {
    return ScaleTransition(
      scale: _heartController,
      child: GestureDetector(
        onTap: _toggleFavourite,
        child: Padding(
          padding: const EdgeInsets.only(left: 4, top: 2),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              _isFavourited
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              key: ValueKey(_isFavourited),
              color: _isFavourited ? const Color(0xFFD44E6F) : _muted,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardBottom() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _divider, width: 1)),
      ),
      child: _GoldButton(
        label: 'Add to Cart',
        onTap: widget.onAddToCart,
        isFlat: true,
      ),
    );
  }
}

// ── Gold Button ───────────────────────────────────────────────────────────────

class _GoldButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isFlat;

  const _GoldButton({
    required this.label,
    required this.onTap,
    this.isFlat = false,
  });

  @override
  State<_GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<_GoldButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: widget.isFlat ? 14 : 16,
        ),
        decoration: BoxDecoration(
          color: _pressed
              ? const Color(0xFF8B6508)
              : (widget.isFlat ? Colors.transparent : const Color(0xFFB8860B)),
          borderRadius:
              widget.isFlat ? null : BorderRadius.circular(8),
          gradient: widget.isFlat
              ? null
              : LinearGradient(
                  colors: _pressed
                      ? [const Color(0xFF8B6508), const Color(0xFFA07010)]
                      : [const Color(0xFFD4A017), const Color(0xFFB8860B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 16,
              color: widget.isFlat
                  ? const Color(0xFFB8860B)
                  : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: widget.isFlat
                    ? const Color(0xFFB8860B)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}