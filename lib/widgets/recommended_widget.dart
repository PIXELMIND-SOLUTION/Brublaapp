import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
import 'package:brublaapp/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class RecommendedRow extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const RecommendedRow({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          _sectionHeader('Recommended'),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => SizedBox(
                width: 140,
                child: ProductCard(
                  item: items[i],
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen()));
                  },
                ),
              ),
            ),
          ),
        ],
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
        const Text(
          'View all >>',
          style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ],
    );
  }
}