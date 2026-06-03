// // ignore_for_file: deprecated_member_use

// import 'package:brublaapp/model/address_model.dart';
// import 'package:brublaapp/views/address/address_screen.dart';
// import 'package:brublaapp/views/cart/cart_screen.dart';
// import 'package:brublaapp/views/guide/size_guide_screen.dart';
// import 'package:brublaapp/views/home/exclusive_screen.dart';
// import 'package:brublaapp/views/profile/designer_profile.dart';
// import 'package:flutter/material.dart';

// class SingleDetailScreen extends StatefulWidget {
//   const SingleDetailScreen({super.key});

//   @override
//   State<SingleDetailScreen> createState() => _SingleDetailScreenState();
// }

// class _SingleDetailScreenState extends State<SingleDetailScreen> {
//   String selectedSize = 'X';
//   int _selectedTab = 0;
//   int _selectedImageIndex = 0;

//   final List<String> _productImages = [
//     'assets/orderimage.png',
//     'assets/detailscreenimage.png',
//     'assets/homecard.png',
//   ];

//   AddressModel? _selectedAddress;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeroSection(context),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 14),
//                     _buildTitlePrice(),
//                     const SizedBox(height: 14),
//                     _buildSizeSelector(),
//                     const SizedBox(height: 14),
//                     _buildDesignerSection(),
//                     const SizedBox(height: 10),
//                     _buildDeliveryBanner(),
//                     const SizedBox(height: 14),
//                     _buildDeliveryDetails(),
//                     const SizedBox(height: 14),
//                     _buildDescriptionTabs(),
//                     const SizedBox(height: 10),
//                     if (_selectedTab == 0) _buildDescriptionText(),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),

//               _buildActionButtons(),
//               const SizedBox(height: 20),
//               _buildSectionHeader('Designer Products'),
//               _buildProductGrid(),
//               const SizedBox(height: 16),
//               _buildSectionHeader('Related Products'),
//               _buildRelatedProductsRow(),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeroSection(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 300,
//           color: const Color(0xFFF5EFE6),
//           child: Image.asset(
//             _productImages[_selectedImageIndex],
//             fit: BoxFit.cover,
//           ),
//         ),

//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             height: 90,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [Color(0x88000000), Colors.transparent],
//               ),
//             ),
//           ),
//         ),

//         Positioned(
//           top: 12,
//           left: 12,
//           child: GestureDetector(
//             onTap: () => Navigator.maybePop(context),
//             child: Container(
//               width: 34,
//               height: 34,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.arrow_back_ios_new,
//                 size: 16,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ),

//         Positioned(
//           bottom: 12,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(_productImages.length, (i) {
//               final isSelected = _selectedImageIndex == i;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedImageIndex = i),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   width: 56,
//                   height: 56,
//                   margin: const EdgeInsets.symmetric(horizontal: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: isSelected
//                           ? const Color(0xFFB8860B)
//                           : Colors.white.withOpacity(0.6),
//                       width: isSelected ? 2.5 : 1.5,
//                     ),
//                     boxShadow: isSelected
//                         ? [
//                             BoxShadow(
//                               color: const Color(0xFFB8860B).withOpacity(0.4),
//                               blurRadius: 6,
//                               offset: const Offset(0, 2),
//                             ),
//                           ]
//                         : [],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(_productImages[i], fit: BoxFit.cover),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),

//         Positioned(
//           bottom: -2,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(_productImages.length, (i) {
//               final isSelected = _selectedImageIndex == i;
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
//                 width: isSelected ? 16 : 6,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? const Color(0xFFB8860B)
//                       : Colors.grey.shade400,
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTitlePrice() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Tommy Shirts',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(221, 255, 255, 255),
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             const Text(
//               '\$ 5000/-',
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(221, 255, 255, 255),
//               ),
//             ),
//             Text(
//               '\$ 9000/-',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade500,
//                 decoration: TextDecoration.lineThrough,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSizeSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Select Your Size',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: ['X', 'XL'].map((size) {
//                 final isSelected = selectedSize == size;
//                 return GestureDetector(
//                   onTap: () => setState(() => selectedSize = size),
//                   child: Container(
//                     margin: const EdgeInsets.only(right: 8),
//                     width: 38,
//                     height: 38,
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color(0xFF2C2C2C)
//                           : Colors.white,
//                       border: Border.all(
//                         color: isSelected
//                             ? const Color(0xFF2C2C2C)
//                             : Colors.grey.shade300,
//                       ),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Center(
//                       child: Text(
//                         size,
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: isSelected ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SizeGuideScreen()),
//             );
//           },
//           child: const Text(
//             'Size Guide',
//             style: TextStyle(color: Color(0xFFB8860B), fontSize: 13),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDesignerSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Designer',
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DesignerProfile()),
//                 );
//               },
//               child: Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFFF5EFE6),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: ClipOval(
//                   child: Image.asset(
//                     'assets/detailprofile.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Brubla Orginal',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 Text(
//                   'New Profile',
//                   style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDeliveryBanner() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ExclusiveScreen()),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFFFFF3CD), Color(0xFFFFE082)],
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Subscribe Now To Get A Free Delivery',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF5D4037),
//                     ),
//                   ),
//                   Text(
//                     'For Next Five Orders',
//                     style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.5),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 13,
//                 color: Color(0xFF5D4037),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget _buildDeliveryDetails() {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       const Text(
//   //         'Delivery  Details',
//   //         style: TextStyle(
//   //           fontSize: 14,
//   //           fontWeight: FontWeight.bold,
//   //           color: Colors.black87,
//   //         ),
//   //       ),
//   //       const SizedBox(height: 8),
//   //       Row(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           const Icon(
//   //             Icons.location_on_outlined,
//   //             size: 16,
//   //             color: Color(0xFFB8860B),
//   //           ),
//   //           const SizedBox(width: 6),
//   //           Expanded(
//   //             child: Text(
//   //               'Hyderabad, Telangana, Kukatpally, Kphb colony, 500072. Delivery on 20 August',
//   //               style: TextStyle(
//   //                 fontSize: 12,
//   //                 color: Colors.grey.shade600,
//   //                 height: 1.4,
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //       const SizedBox(height: 8),
//   //       Row(
//   //         children: [
//   //           const Icon(Icons.add, size: 14, color: Color(0xFFB8860B)),
//   //           const SizedBox(width: 4),
//   //           const Text(
//   //             'ADD NEW ADDRESS',
//   //             style: TextStyle(
//   //               fontSize: 12,
//   //               fontWeight: FontWeight.w600,
//   //               color: Color(0xFFB8860B),
//   //             ),
//   //           ),
//   //           const Spacer(),
//   //           Text(
//   //             'View All >>',
//   //             style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _buildDeliveryDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Delivery Details',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(
//               Icons.location_on_outlined,
//               size: 16,
//               color: Color(0xFFB8860B),
//             ),
//             const SizedBox(width: 6),
//             Expanded(
//               child: Text(
//                 _selectedAddress != null
//                     ? [
//                         _selectedAddress!.address,
//                         if (_selectedAddress!.landmark != null &&
//                             _selectedAddress!.landmark!.isNotEmpty)
//                           _selectedAddress!.landmark!,
//                         _selectedAddress!.city,
//                         '${_selectedAddress!.state} ${_selectedAddress!.pincode}',
//                       ].join(', ')
//                     : 'No address selected. Tap below to add one.',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey.shade600,
//                   height: 1.4,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 final result = await Navigator.push<AddressModel>(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         const AddressScreen(selectionMode: true),
//                   ),
//                 );
//                 if (result != null) {
//                   setState(() => _selectedAddress = result);
//                 }
//               },
//               child: const Row(
//                 children: [
//                   Icon(Icons.add, size: 14, color: Color(0xFFB8860B)),
//                   SizedBox(width: 4),
//                   Text(
//                     'ADD NEW ADDRESS',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFFB8860B),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             if (_selectedAddress != null)
//               GestureDetector(
//                 onTap: () async {
//                   final result = await Navigator.push<AddressModel>(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           const AddressScreen(selectionMode: true),
//                     ),
//                   );
//                   if (result != null) {
//                     setState(() => _selectedAddress = result);
//                   }
//                 },
//                 child: Text(
//                   'Change >>',
//                   style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
//                 ),
//               ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDescriptionTabs() {
//     return Row(
//       children: [
//         _tabItem('Description', 0),
//         const SizedBox(width: 20),
//         _tabItem('Reviews', 1),
//       ],
//     );
//   }

//   Widget _tabItem(String label, int index) {
//     final isActive = _selectedTab == index;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedTab = index),
//       child: Column(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
//               color: isActive ? Colors.black87 : Colors.grey.shade500,
//             ),
//           ),
//           const SizedBox(height: 4),
//           if (isActive)
//             Container(
//               height: 2,
//               width: label.length * 7.5,
//               decoration: BoxDecoration(
//                 color: Colors.black87,
//                 borderRadius: BorderRadius.circular(1),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDescriptionText() {
//     return Text(
//       'Explore a wide range of high-quality products tailored to meet your everyday needs. Our e-commerce platform offers a seamless shopping experience with secure payments, fast delivery, and easy returns. Discover trending items, exclusive deals, and personalized recommendations—all in one place.',
//       style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.55),
//       maxLines: 5,
//       overflow: TextOverflow.ellipsis,
//     );
//   }

//   Widget _buildActionButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CartScreen()),
//                 );
//               },
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 0, 0, 0),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Cart',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {},
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   color: const Color.fromARGB(255, 255, 255, 255),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Buy',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           Text(
//             'View All',
//             style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductGrid() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(child: _productCard()),
//               const SizedBox(width: 12),
//               Expanded(child: _productCard()),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(child: _productCard()),
//               const SizedBox(width: 12),
//               Expanded(child: _productCard()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRelatedProductsRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: List.generate(
//           2,
//           (_) => Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: _productCard(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _productCard() {
//     return Container(
//       height: 180,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(10),
//               ),
//               child: Container(
//                 width: double.infinity,
//                 color: const Color(0xFFF5EFE6),
//                 child: Image.asset('assets/homecard.png', fit: BoxFit.cover),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Tommy Shirts',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 const Text(
//                   '\$ 200/-',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFFB8860B),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





















// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:brublaapp/model/address_model.dart';
import 'package:brublaapp/views/address/address_screen.dart';
import 'package:brublaapp/views/cart/cart_screen.dart';
import 'package:brublaapp/views/guide/size_guide_screen.dart';
import 'package:brublaapp/views/home/exclusive_screen.dart';
import 'package:brublaapp/views/profile/designer_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SizeStock {
  final String size;
  final int stock;
  final String id;

  SizeStock({required this.size, required this.stock, required this.id});

  factory SizeStock.fromJson(Map<String, dynamic> json) => SizeStock(
        size: json['size'] ?? '',
        stock: json['stock'] ?? 0,
        id: json['_id'] ?? '',
      );
}

class ProductVariant {
  final String color;
  final double price;
  final double? discountPrice;
  final List<SizeStock> sizes;
  final List<String> images;
  final bool isActive;
  final String id;
  final String sku;

  ProductVariant({
    required this.color,
    required this.price,
    this.discountPrice,
    required this.sizes,
    required this.images,
    required this.isActive,
    required this.id,
    required this.sku,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        color: json['color'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        discountPrice: json['discountPrice'] != null
            ? (json['discountPrice']).toDouble()
            : null,
        sizes: (json['sizes'] as List<dynamic>? ?? [])
            .map((s) => SizeStock.fromJson(s))
            .toList(),
        images: List<String>.from(json['images'] ?? []),
        isActive: json['isActive'] ?? true,
        id: json['_id'] ?? '',
        sku: json['sku'] ?? '',
      );
}

class ProductDetail {
  final String id;
  final String name;
  final String description;
  final List<ProductVariant> variants;
  final List<String> mainImages;
  final List<String> deliveryAddresses;
  final double displayPrice;
  final double displayActualPrice;
  final int maxDiscount;
  final List<String> availableColors;
  final List<String> availableSizes;
  final int totalStock;
  final List<String> tags;
  final double averageRating;

  ProductDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.variants,
    required this.mainImages,
    required this.deliveryAddresses,
    required this.displayPrice,
    required this.displayActualPrice,
    required this.maxDiscount,
    required this.availableColors,
    required this.availableSizes,
    required this.totalStock,
    required this.tags,
    required this.averageRating,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>;
    return ProductDetail(
      id: product['_id'] ?? '',
      name: product['name'] ?? '',
      description: product['description'] ?? '',
      variants: (product['variants'] as List<dynamic>? ?? [])
          .map((v) => ProductVariant.fromJson(v))
          .toList(),
      mainImages: List<String>.from(product['mainImages'] ?? []),
      deliveryAddresses:
          List<String>.from(product['deliveryAddresses'] ?? []),
      displayPrice: (product['displayPrice'] ?? 0).toDouble(),
      displayActualPrice: (product['displayActualPrice'] ?? 0).toDouble(),
      maxDiscount: product['maxDiscount'] ?? 0,
      availableColors: List<String>.from(product['availableColors'] ?? []),
      availableSizes: List<String>.from(product['availableSizes'] ?? []),
      totalStock: product['totalStock'] ?? 0,
      tags: List<String>.from(product['tags'] ?? []),
      averageRating: (product['averageRating'] ?? 0).toDouble(),
    );
  }
}


class ProductService {
  static const String _baseUrl = 'http://31.97.228.17:4077';

  static Future<ProductDetail> fetchProduct(String productId) async {
    final uri = Uri.parse('$_baseUrl/api/admin/products/$productId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductDetail.fromJson(json);
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  }
}


class SingleDetailScreen extends StatefulWidget {
  final String productId;

  const SingleDetailScreen({
    super.key,
    this.productId = '6a181c4b5c969b76e197dd57',
  });

  @override
  State<SingleDetailScreen> createState() => _SingleDetailScreenState();
}

class _SingleDetailScreenState extends State<SingleDetailScreen> {
  ProductDetail? _product;
  bool _isLoading = true;
  String? _errorMessage;

  String? _selectedColor;
  String? _selectedSize;
  int _selectedTab = 0;
  int _selectedImageIndex = 0;

  AddressModel? _selectedAddress;


  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final product = await ProductService.fetchProduct(widget.productId);
      setState(() {
        _product = product;
        _isLoading = false;
        // Default selections
        if (product.availableColors.isNotEmpty) {
          _selectedColor = product.availableColors.first;
        }
        if (product.availableSizes.isNotEmpty) {
          _selectedSize = product.availableSizes.first;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }


  ProductVariant? get _selectedVariant {
    if (_product == null || _selectedColor == null) return null;
    try {
      return _product!.variants
          .firstWhere((v) => v.color == _selectedColor);
    } catch (_) {
      return _product!.variants.isNotEmpty ? _product!.variants.first : null;
    }
  }

  List<String> get _currentImages {
    final variant = _selectedVariant;
    if (variant != null && variant.images.isNotEmpty) return variant.images;
    return _product?.mainImages ?? [];
  }

  String _imageUrl(String raw) {
    return raw.replaceFirst('http://localhost:4077', 'http://31.97.228.17:4077');
  }

  int _stockForSize(String size) {
    final variant = _selectedVariant;
    if (variant == null) return 0;
    try {
      return variant.sizes.firstWhere((s) => s.size == size).stock;
    } catch (_) {
      return 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Color(0xFFB8860B))),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Failed to load product',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loadProduct,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB8860B)),
                  child: const Text('Retry',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final product = _product!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    _buildTitlePrice(product),
                    const SizedBox(height: 10),
                    _buildColorSelector(product),
                    const SizedBox(height: 14),
                    _buildSizeSelector(product),
                    const SizedBox(height: 14),
                    _buildDesignerSection(),
                    const SizedBox(height: 10),
                    _buildDeliveryBanner(),
                    const SizedBox(height: 14),
                    _buildDeliveryDetails(product),
                    const SizedBox(height: 14),
                    _buildDescriptionTabs(),
                    const SizedBox(height: 10),
                    if (_selectedTab == 0) _buildDescriptionText(product),
                    if (_selectedTab == 1) _buildReviewsSection(product),
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


  Widget _buildHeroSection(BuildContext context) {
    final images = _currentImages;
    final safeIndex =
        _selectedImageIndex < images.length ? _selectedImageIndex : 0;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          color: const Color(0xFFF5EFE6),
          child: images.isNotEmpty
              ? Image.network(
                  _imageUrl(images[safeIndex]),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported,
                    size: 60,
                    color: Colors.grey,
                  ),
                )
              : const Icon(Icons.image_not_supported,
                  size: 60, color: Colors.grey),
        ),

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
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: Colors.black87),
            ),
          ),
        ),

        // Thumbnail strip
        if (images.isNotEmpty)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (i) {
                final isSelected = safeIndex == i;
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
                                color:
                                    const Color(0xFFB8860B).withOpacity(0.4),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _imageUrl(images[i]),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported,
                              size: 20, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

        if (images.isNotEmpty)
          Positioned(
            bottom: -2,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (i) {
                final isSelected = safeIndex == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 3, vertical: 4),
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


  Widget _buildTitlePrice(ProductDetail product) {
    final variant = _selectedVariant;
    final displayPrice =
        variant?.discountPrice ?? variant?.price ?? product.displayPrice;
    final actualPrice = variant?.price ?? product.displayActualPrice;
    final hasDiscount = variant?.discountPrice != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${displayPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB8860B),
              ),
            ),
            if (hasDiscount)
              Text(
                '\$${actualPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (hasDiscount)
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${product.maxDiscount}% OFF',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }


  Widget _buildColorSelector(ProductDetail product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Color:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedColor ?? '',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: product.availableColors.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                  _selectedImageIndex = 0;
                  final newVariant = _product!.variants
                      .firstWhere((v) => v.color == color,
                          orElse: () => _product!.variants.first);
                  final sizes =
                      newVariant.sizes.map((s) => s.size).toList();
                  if (_selectedSize == null ||
                      !sizes.contains(_selectedSize)) {
                    _selectedSize =
                        sizes.isNotEmpty ? sizes.first : null;
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
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
                child: Text(
                  color,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Size Selector ──────────────────────────────────────────────────────────

  Widget _buildSizeSelector(ProductDetail product) {
    final variant = _selectedVariant;
    final availableSizes =
        variant?.sizes.map((s) => s.size).toList() ?? product.availableSizes;

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
              children: availableSizes.map((size) {
                final isSelected = _selectedSize == size;
                final stock = _stockForSize(size);
                final outOfStock = stock == 0;
                return GestureDetector(
                  onTap: outOfStock
                      ? null
                      : () => setState(() => _selectedSize = size),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: outOfStock
                          ? Colors.grey.shade100
                          : isSelected
                              ? const Color(0xFF2C2C2C)
                              : Colors.white,
                      border: Border.all(
                        color: outOfStock
                            ? Colors.grey.shade300
                            : isSelected
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
                          color: outOfStock
                              ? Colors.grey.shade400
                              : isSelected
                                  ? Colors.white
                                  : Colors.black87,
                          decoration: outOfStock
                              ? TextDecoration.lineThrough
                              : null,
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SizeGuideScreen()),
            );
          },
          child: const Text(
            'Size Guide',
            style: TextStyle(color: Color(0xFFB8860B), fontSize: 13),
          ),
        ),
      ],
    );
  }

  // ── Designer Section ───────────────────────────────────────────────────────

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DesignerProfile()),
                );
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5EFE6),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/detailprofile.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person, size: 24, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Brubla Original',
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

  // ── Delivery Banner ────────────────────────────────────────────────────────

  Widget _buildDeliveryBanner() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExclusiveScreen()),
        );
      },
      child: Container(
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
      ),
    );
  }

  // ── Delivery Details ───────────────────────────────────────────────────────

  Widget _buildDeliveryDetails(ProductDetail product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        // Delivery cities from API
        if (product.deliveryAddresses.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.local_shipping_outlined,
                  size: 16, color: Color(0xFFB8860B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Ships to: ${product.deliveryAddresses.join(', ')}',
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
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_outlined,
                size: 16, color: Color(0xFFB8860B)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _selectedAddress != null
                    ? [
                        _selectedAddress!.address,
                        if (_selectedAddress!.landmark != null &&
                            _selectedAddress!.landmark!.isNotEmpty)
                          _selectedAddress!.landmark!,
                        _selectedAddress!.city,
                        '${_selectedAddress!.state} ${_selectedAddress!.pincode}',
                      ].join(', ')
                    : 'No address selected. Tap below to add one.',
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
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push<AddressModel>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AddressScreen(selectionMode: true),
                  ),
                );
                if (result != null) {
                  setState(() => _selectedAddress = result);
                }
              },
              child: const Row(
                children: [
                  Icon(Icons.add, size: 14, color: Color(0xFFB8860B)),
                  SizedBox(width: 4),
                  Text(
                    'ADD NEW ADDRESS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB8860B),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (_selectedAddress != null)
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push<AddressModel>(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddressScreen(selectionMode: true),
                    ),
                  );
                  if (result != null) {
                    setState(() => _selectedAddress = result);
                  }
                },
                child: Text(
                  'Change >>',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ── Description Tabs ───────────────────────────────────────────────────────

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

  Widget _buildDescriptionText(ProductDetail product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.description,
          style: TextStyle(
              fontSize: 12, color: Colors.grey.shade600, height: 1.55),
        ),
        if (product.tags.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: product.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EFE6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFB8860B).withOpacity(0.3)),
                ),
                child: Text(
                  '#$tag',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFB8860B),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildReviewsSection(ProductDetail product) {
    if (product.averageRating == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'No reviews yet. Be the first to review!',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  // ── Action Buttons ─────────────────────────────────────────────────────────

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Add to Cart',
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
                  border: Border.all(color: const Color(0xFF2C2C2C)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
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

  // ── Section Header ─────────────────────────────────────────────────────────

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

  // ── Product Grid (static placeholders) ────────────────────────────────────

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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                width: double.infinity,
                color: const Color(0xFFF5EFE6),
                child: Image.asset('assets/homecard.png', fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey)),
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
