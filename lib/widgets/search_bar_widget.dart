import 'dart:async';
import 'package:flutter/material.dart';
import 'package:brublaapp/views/home/search_screen.dart';
import 'package:brublaapp/views/wishlist/wishlist_screen.dart';
import 'package:brublaapp/views/cart/cart_screen.dart';

class SearchBarWidget extends StatefulWidget {
  final List<String> searchKeywords;
  
  const SearchBarWidget({
    super.key,
    required this.searchKeywords,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  int _currentKeywordIndex = 0;
  late Timer _keywordTimer;

  @override
  void initState() {
    super.initState();
    _keywordTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _currentKeywordIndex =
            (_currentKeywordIndex + 1) % widget.searchKeywords.length;
      });
    });
  }

  @override
  void dispose() {
    _keywordTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(_currentKeywordIndex),
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 20, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                          children: [
                            const TextSpan(text: 'Search for "'),
                            TextSpan(
                              text: widget.searchKeywords[_currentKeywordIndex],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: '"'),
                          ],
                        ),
                      ),
                    ],
                  ),
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
}