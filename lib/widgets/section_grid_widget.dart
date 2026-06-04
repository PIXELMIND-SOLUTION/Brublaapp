// import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
// import 'package:brublaapp/widgets/product_card_widget.dart';
// import 'package:flutter/material.dart';

// class SectionGrid extends StatelessWidget {
//   final String title;
//   final List<Map<String, dynamic>> items;
//   final bool showSelected;
//   final VoidCallback? onViewAllTap;

//   const SectionGrid({
//     super.key,
//     required this.title,
//     required this.items,
//     this.showSelected = false,
//     this.onViewAllTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Column(
//         children: [
//           _sectionHeader(title, onViewAllTap),
//           const SizedBox(height: 12),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 0.82,
//             ),
//             itemCount: items.length,
//             itemBuilder: (_, i) => ProductCard(
//               item: items[i],
//               showBorder: showSelected && items[i]['selected'] == true,
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen()));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionHeader(String title, VoidCallback? onTap) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 0, 0, 0),
//           ),
//         ),
//         GestureDetector(
//           onTap: onTap,
//           child: const Text(
//             'View all >>',
//             style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
//           ),
//         ),
//       ],
//     );
//   }
// }




/////////////////////// Above is the code used previously static data///////////////









//////////////////////// This is the dynamic SectionGrid data////////////////////////

// ignore_for_file: dangling_library_doc_comments

import 'dart:convert';
import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
import 'package:brublaapp/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SectionGrid extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>>? items;
  final bool showSelected;
  final VoidCallback? onViewAllTap;

  const SectionGrid({
    super.key,
    required this.title,
    this.items,
    this.showSelected = false,
    this.onViewAllTap,
  });

  @override
  State<SectionGrid> createState() => _SectionGridState();
}

class _SectionGridState extends State<SectionGrid> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.items != null) {
      _items = widget.items!;
      _isLoading = false;
    } else {
      _fetchProducts();
    }
  }

  Future<void> _fetchProducts() async {
    const url = 'http://31.97.228.17:4077/api/users/latest';
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      print(
        '❤️  Response status code for latest designsssss: ${response.statusCode}',
      );

      print(
        '🌟 Response bodyyyyyyyy code for latest designsssss: ${response.body}',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json['success'] == true) {
          final List<dynamic> data = json['data'];

          final List<Map<String, dynamic>> mapped = data.map((product) {
            String imageUrl = product['mainImage'] ?? '';
            if (imageUrl.contains('localhost')) {
              imageUrl = imageUrl.replaceFirst(
                RegExp(r'http://localhost:\d+'),
                'http://31.97.228.17:4077',
              );
            }

            return {
              'id': product['_id'],
              'name': product['name'],
              'description': product['description'],
              'price': product['displayPrice'],
              'actualPrice': product['displayActualPrice'],
              'discount': product['maxDiscount'],
              'image': imageUrl,
              'rating': product['averageRating'],
              'selected': false,
            };
          }).toList();

          setState(() {
            _items = mapped;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Failed to load products.';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _sectionHeader(widget.title, widget.onViewAllTap),
          const SizedBox(height: 12),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _fetchProducts();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            )
          else if (_items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No products available.')),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemCount: _items.length,
              itemBuilder: (_, i) => ProductCard(
                item: _items[i],
                showBorder:
                    widget.showSelected && _items[i]['selected'] == true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, VoidCallback? onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'View all >>',
            style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ],
    );
  }
}
