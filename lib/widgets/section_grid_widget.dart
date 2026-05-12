import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
import 'package:brublaapp/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class SectionGrid extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final bool showSelected;
  final VoidCallback? onViewAllTap;

  const SectionGrid({
    super.key,
    required this.title,
    required this.items,
    this.showSelected = false,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _sectionHeader(title, onViewAllTap),
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
            itemBuilder: (_, i) => ProductCard(
              item: items[i],
              showBorder: showSelected && items[i]['selected'] == true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen()));
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