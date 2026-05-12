import 'package:brublaapp/views/details/detail_screen.dart' hide ProductCard;
import 'package:brublaapp/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class MostSalesSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const MostSalesSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          _sectionHeader('Most Sales'),
          const SizedBox(height: 12),
          Row(
            children: items
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AspectRatio(
                        aspectRatio: 0.78,
                        child: ProductCard(
                          item: item,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen()));
                          },
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
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