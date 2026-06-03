import 'dart:convert';
import 'package:brublaapp/views/details/single_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubcategoryProductsResponse {
  final String categoryName;
  final String subcategoryName;
  final String? subcategoryImage;
  final int count;
  final List<ProductModel> products;

  SubcategoryProductsResponse({
    required this.categoryName,
    required this.subcategoryName,
    this.subcategoryImage,
    required this.count,
    required this.products,
  });

  factory SubcategoryProductsResponse.fromJson(Map<String, dynamic> json) {
    return SubcategoryProductsResponse(
      categoryName: json['category']?['name'] ?? '',
      subcategoryName: json['subcategory']?['name'] ?? '',
      subcategoryImage: json['subcategory']?['image'],
      count: json['count'] ?? 0,
      products: (json['products'] as List<dynamic>? ?? [])
          .map((p) => ProductModel.fromJson(p))
          .toList(),
    );
  }
}

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double displayPrice;
  final double displayActualPrice;
  final int maxDiscount;
  final String? mainImage;
  final List<String> availableColors;
  final List<String> availableSizes;
  final int totalStock;
  final double averageRating;
  final List<VariantModel> variants;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.displayPrice,
    required this.displayActualPrice,
    required this.maxDiscount,
    this.mainImage,
    required this.availableColors,
    required this.availableSizes,
    required this.totalStock,
    required this.averageRating,
    required this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      displayPrice: (json['displayPrice'] ?? 0).toDouble(),
      displayActualPrice: (json['displayActualPrice'] ?? 0).toDouble(),
      maxDiscount: json['maxDiscount'] ?? 0,
      mainImage: json['mainImage'],
      availableColors: List<String>.from(json['availableColors'] ?? []),
      availableSizes: List<String>.from(json['availableSizes'] ?? []),
      totalStock: json['totalStock'] ?? 0,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      variants: (json['variants'] as List<dynamic>? ?? [])
          .map((v) => VariantModel.fromJson(v))
          .toList(),
    );
  }

  String? get firstVariantImage {
    for (final variant in variants) {
      if (variant.images.isNotEmpty) {
        final img = variant.images.first;
        return _resolveImageUrl(img);
      }
    }
    return null;
  }

  String? get resolvedMainImage =>
      mainImage != null ? _resolveImageUrl(mainImage!) : null;

  String? get bestImage => resolvedMainImage ?? firstVariantImage;

  static String _resolveImageUrl(String url) {
    if (url.isEmpty) return url;
    if (url.startsWith('http')) {
      return url.replaceFirst('localhost', '31.97.228.17');
    }
    return 'http://31.97.228.17:4077$url';
  }
}

class VariantModel {
  final String color;
  final double price;
  final double? discountPrice;
  final List<String> images;

  VariantModel({
    required this.color,
    required this.price,
    this.discountPrice,
    required this.images,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      color: json['color'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: json['discountPrice'] != null
          ? (json['discountPrice']).toDouble()
          : null,
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class SubcategoryProductsScreen extends StatefulWidget {
  final String subcategoryId;
  final String subcategoryName;
  final String? subcategoryImage;

  const SubcategoryProductsScreen({
    super.key,
    required this.subcategoryId,
    required this.subcategoryName,
    this.subcategoryImage,
  });

  @override
  State<SubcategoryProductsScreen> createState() =>
      _SubcategoryProductsScreenState();
}

class _SubcategoryProductsScreenState extends State<SubcategoryProductsScreen> {
  SubcategoryProductsResponse? _data;
  bool _isLoading = true;
  String? _errorMessage;

  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final url = Uri.parse(
        'http://31.97.228.17:4077/api/admin/subcategories/${widget.subcategoryId}/products',
      );
      final response = await http.get(url);

      print(
        'Response status code for get subcategory by iddddd: ${response.statusCode}',
      );
      print(
        'Response bodyyyyyyyyyyyy for get subcategory by iddddd: ${response.body}',
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        if (json['success'] == true) {
          setState(() {
            _data = SubcategoryProductsResponse.fromJson(json);
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Failed to load products';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: $e';
        _isLoading = false;
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color(0xFFF8F8F8),
  //     body: CustomScrollView(
  //       slivers: [
  //         // _buildSliverAppBar(context),
  //         if (_isLoading)
  //           const SliverFillRemaining(
  //             child: Center(child: CircularProgressIndicator()),
  //           )
  //         else if (_errorMessage != null)
  //           SliverFillRemaining(child: _buildErrorState())
  //         else if (_data != null && _data!.products.isEmpty)
  //           const SliverFillRemaining(
  //             child: Center(
  //               child: Text(
  //                 'No products found',
  //                 style: TextStyle(color: Colors.grey, fontSize: 14),
  //               ),
  //             ),
  //           )
  //         else ...[
  //           _buildProductCount(),
  //           _isGridView ? _buildGridView() : _buildListView(),
  //           const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
  //         ],
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (_data?.categoryName.isNotEmpty ?? false)
            //   Text(
            //     _data!.categoryName,
            //     style: TextStyle(
            //       fontSize: 11,
            //       color: Colors.grey.shade500,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            Text(
              _data?.subcategoryName ?? widget.subcategoryName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: Colors.black,
            ),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_errorMessage != null)
            SliverFillRemaining(child: _buildErrorState())
          else if (_data != null && _data!.products.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'No products found',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            )
          else ...[
            _buildProductCount(),
            _isGridView ? _buildGridView() : _buildListView(),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ],
      ),
    );
  }

  // Widget _buildSliverAppBar(BuildContext context) {
  //   return SliverAppBar(
  //     expandedHeight: 160,
  //     pinned: true,
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     leading: IconButton(
  //       icon: const Icon(
  //         Icons.arrow_back_ios_new,
  //         color: Colors.black,
  //         size: 18,
  //       ),
  //       onPressed: () => Navigator.pop(context),
  //     ),
  //     actions: [
  //       IconButton(
  //         icon: Icon(
  //           _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
  //           color: Colors.black,
  //         ),
  //         onPressed: () => setState(() => _isGridView = !_isGridView),
  //       ),
  //       // IconButton(
  //       //   icon: const Icon(Icons.tune_rounded, color: Colors.black),
  //       //   onPressed: () {},
  //       // ),
  //     ],
  //     flexibleSpace: FlexibleSpaceBar(
  //       titlePadding: const EdgeInsets.only(left: 56, bottom: 14),
  //       title: Text(
  //         _data?.subcategoryName ?? widget.subcategoryName,
  //         style: const TextStyle(
  //           color: Colors.black,
  //           fontSize: 16,
  //           fontWeight: FontWeight.w700,
  //           letterSpacing: -0.3,
  //         ),
  //       ),
  //       background: _buildAppBarBackground(),
  //     ),
  //   );
  // }

  // Widget _buildAppBarBackground() {
  //   return Container(
  //     color: Colors.white,
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           right: -20,
  //           top: -20,
  //           child: Container(
  //             width: 160,
  //             height: 160,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: Colors.grey.shade100,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 56,
  //           bottom: 42,
  //           child: Row(
  //             children: [
  //               Text(
  //                 _data?.categoryName ?? '',
  //                 style: TextStyle(
  //                   fontSize: 11,
  //                   color: Colors.grey.shade500,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               if (_data?.categoryName.isNotEmpty ?? false)
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 4),
  //                   child: Icon(
  //                     Icons.chevron_right,
  //                     size: 12,
  //                     color: Colors.grey.shade400,
  //                   ),
  //                 ),
  //               Text(
  //                 _data?.subcategoryName ?? widget.subcategoryName,
  //                 style: const TextStyle(
  //                   fontSize: 11,
  //                   color: Colors.black54,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProductCount() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_data!.count} Products',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.sort_rounded,
                    size: 16,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Sort',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _ProductGridCard(product: _data!.products[index]),
          childCount: _data!.products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ProductListCard(product: _data!.products[index]),
          ),
          childCount: _data!.products.length,
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Something went wrong',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
              ),
              onPressed: _fetchProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  final ProductModel product;

  const _ProductGridCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleDetailScreen(productId: product.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: _ProductImage(
                      imageUrl: product.bestImage,
                      name: product.name,
                    ),
                  ),
                  if (product.maxDiscount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _DiscountBadge(discount: product.maxDiscount),
                    ),
                  Positioned(top: 6, right: 6, child: _WishlistButton()),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _PriceRow(
                      price: product.displayPrice,
                      actualPrice: product.displayActualPrice,
                      compact: true,
                    ),
                    const SizedBox(height: 6),
                    _ColorDots(colors: product.availableColors),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductListCard extends StatelessWidget {
  final ProductModel product;

  const _ProductListCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleDetailScreen(productId: product.id),
          ),
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
              child: SizedBox(
                width: 110,
                height: 130,
                child: Stack(
                  children: [
                    _ProductImage(
                      imageUrl: product.bestImage,
                      name: product.name,
                    ),
                    if (product.maxDiscount > 0)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: _DiscountBadge(discount: product.maxDiscount),
                      ),
                  ],
                ),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _PriceRow(
                          price: product.displayPrice,
                          actualPrice: product.displayActualPrice,
                          compact: false,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _ColorDots(colors: product.availableColors),
                        const Spacer(),
                        Text(
                          '${product.availableSizes.length} sizes',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
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
}

class _ProductImage extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const _ProductImage({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        color: Colors.grey.shade100,
        child: Center(
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      );
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade100,
        child: Center(
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Colors.grey.shade100,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final int discount;

  const _DiscountBadge({required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '-$discount%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _WishlistButton extends StatefulWidget {
  @override
  State<_WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<_WishlistButton> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _liked = !_liked),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _liked ? Icons.favorite : Icons.favorite_border,
          size: 15,
          color: _liked ? Colors.red : Colors.grey.shade500,
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final double price;
  final double actualPrice;
  final bool compact;

  const _PriceRow({
    required this.price,
    required this.actualPrice,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: compact ? 13 : 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        if (price < actualPrice) ...[
          const SizedBox(width: 5),
          Text(
            '\$${actualPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: compact ? 11 : 12,
              color: Colors.grey.shade400,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}

class _ColorDots extends StatelessWidget {
  final List<String> colors;

  const _ColorDots({required this.colors});

  static const _colorMap = {
    'black': Color(0xFF1A1A1A),
    'white': Color(0xFFEEEEEE),
    'navy blue': Color(0xFF1B2A6B),
    'red': Color(0xFFE53935),
    'blue': Color(0xFF1565C0),
    'green': Color(0xFF2E7D32),
    'yellow': Color(0xFFF9A825),
    'pink': Color(0xFFE91E8C),
    'grey': Color(0xFF9E9E9E),
    'gray': Color(0xFF9E9E9E),
    'brown': Color(0xFF6D4C41),
    'orange': Color(0xFFEF6C00),
    'purple': Color(0xFF6A1B9A),
  };

  Color _resolveColor(String name) {
    return _colorMap[name.toLowerCase()] ?? Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final shown = colors.take(4).toList();
    return Row(
      children: [
        ...shown.map(
          (c) => Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: _resolveColor(c),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
            ),
          ),
        ),
        if (colors.length > 4)
          Text(
            '+${colors.length - 4}',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
      ],
    );
  }
}
