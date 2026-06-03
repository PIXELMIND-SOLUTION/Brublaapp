// import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
// import 'package:brublaapp/widgets/product_card_widget.dart';
// import 'package:flutter/material.dart';

// class RecommendedRow extends StatelessWidget {
//   final List<Map<String, dynamic>> items;

//   const RecommendedRow({super.key, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: Column(
//         children: [
//           _sectionHeader('Recommended'),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 160,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: items.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 12),
//               itemBuilder: (_, i) => SizedBox(
//                 width: 140,
//                 child: ProductCard(
//                   item: items[i],
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen()));
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionHeader(String title) {
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
//         const Text(
//           'View all >>',
//           style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
//         ),
//       ],
//     );
//   }
// }

/////////////// New code for showing dynamic data/////////////////




import 'dart:convert';
import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
import 'package:brublaapp/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendedRow extends StatefulWidget {
  const RecommendedRow({super.key});

  @override
  State<RecommendedRow> createState() => _RecommendedRowState();
}

class _RecommendedRowState extends State<RecommendedRow> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchRecommended();
  }

  Future<void> _fetchRecommended() async {
    try {
      final response = await http.get(
        Uri.parse('http://31.97.228.17:4077/api/users/recommended'),
        headers: {'Content-Type': 'application/json'},
      );

      print(
        '⏳ Response status code for get recommended product ${response.statusCode} ',
      );
      print(
        '🌐 Response bodyyyyyyyyyy for get recommended product ${response.body} ',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['success'] == true) {
          final List<dynamic> data = body['data'];
          setState(() {
            _items = data.map((e) {
              String imageUrl = e['mainImage'] ?? '';
              imageUrl = imageUrl.replaceAll(
                'http://localhost:4077',
                'http://31.97.228.17:4077',
              );

               imageUrl = imageUrl.replaceAll('localhost', '31.97.228.17');
              return {
                'name': e['name'] ?? '',
                'image': imageUrl,
                'price': '\$ ${e['displayPrice']?.toString() ?? '0'}',
                'original': '\$ ${e['displayActualPrice']?.toString() ?? '0'}',
                'discount': '${e['maxDiscount']?.toString() ?? '0'}% off',
                'rating': e['averageRating']?.toString() ?? '0',
                '_id': e['_id'] ?? '',
              };
            }).toList();
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'Failed to load recommendations';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Network error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          _sectionHeader('Recommended'),
          const SizedBox(height: 12),
          SizedBox(height: 160, child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _fetchRecommended();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_items.isEmpty) {
      return const Center(child: Text('No recommendations available'));
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) => SizedBox(
        width: 140,
        child: ProductCard(
          item: _items[i],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(product: _items[i].toString()),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
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
        // const Text(
        //   'View all >>',
        //   style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
        // ),
      ],
    );
  }
}
