// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';

// class ProductCard extends StatefulWidget {
//   final Map<String, dynamic> item;
//   final bool showBorder;
//   final VoidCallback? onTap;

//   const ProductCard({
//     super.key,
//     required this.item,
//     this.showBorder = false,
//     this.onTap,
//   });

//   @override
//   State<ProductCard> createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   bool _isWishlisted = false;

//   @override
//   void initState() {
//     super.initState();
//     _isWishlisted = widget.item['wishlisted'] as bool? ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: widget.showBorder
//               ? Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2)
//               : Border.all(color: Colors.grey.shade200),
//         ),
//         clipBehavior: Clip.hardEdge,
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Image.asset(
//                 widget.item['image'] as String,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) =>
//                     Container(color: Colors.grey.shade200),
//               ),
//             ),
//             Positioned(
//               top: 8,
//               right: 8,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isWishlisted = !_isWishlisted;
//                   });
//                 },
//                 child: Container(
//                   width: 30,
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.85),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     _isWishlisted ? Icons.favorite : Icons.favorite_border,
//                     size: 16,
//                     color: _isWishlisted ? Colors.red : Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ),
//             if (widget.item['discount'] != null)
//               Positioned(
//                 top: 8,
//                 left: 8,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 223, 223, 223),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Text(
//                     widget.item['discount'] as String,
//                     style: const TextStyle(
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [Colors.black87, Colors.transparent],
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.item['name'] as String,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           widget.item['price'] as String,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           widget.item['original'] as String,
//                           style: const TextStyle(
//                             color: Colors.white54,
//                             fontSize: 10,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (widget.item['rating'] != null)
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.amber, size: 12),
//                           const SizedBox(width: 2),
//                           Text(
//                             widget.item['rating'] as String,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

































/////////////////// Above is the original code used previously (Static data) ////////////////////////









///////////// New code for added the dynamic data dont delete the previous code///////////

// ignore_for_file: deprecated_member_use, dangling_library_doc_comments

import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final bool showBorder;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.item,
    this.showBorder = false,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isWishlisted = false;

  @override
  void initState() {
    super.initState();
    _isWishlisted = widget.item['wishlisted'] as bool? ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.item['image']?.toString() ?? '';
    final String name = widget.item['name']?.toString() ?? '';
    final String price = widget.item['price'] != null
        ? '\$${widget.item['price']}'
        : '';
    final String original = widget.item['original'] != null
        ? '\$${widget.item['original']}'
        : '';
    final String discount = widget.item['discount'] != null
        ? '${widget.item['discount']}% OFF'
        : '';
    final String rating = widget.item['rating'] != null
        ? widget.item['rating'].toString()
        : '';

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: widget.showBorder
              ? Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2)
              : Border.all(color: Colors.grey.shade200),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
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
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.grey.shade200),
                    ),
            ),

            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isWishlisted = !_isWishlisted;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isWishlisted ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: _isWishlisted ? Colors.red : Colors.grey.shade600,
                  ),
                ),
              ),
            ),

            if (discount.isNotEmpty)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 223, 223, 223),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

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
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          original,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    if (rating.isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            rating,
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
      ),
    );
  }
}
