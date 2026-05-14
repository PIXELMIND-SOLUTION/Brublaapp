import 'package:flutter/material.dart';

class StatusStep extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final bool isDone;
  final bool isPending;

  const StatusStep({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    this.isDone = false,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isDone
        ? Colors.black
        : isPending
        ? Colors.amber[100]!
        : Colors.grey[100]!;

    final Widget badge = isDone
        ? const Icon(Icons.check, color: Colors.white, size: 16)
        : Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: isPending ? Colors.amber[800] : Colors.black38,
            ),
          );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDone
            ? Colors.black.withOpacity(0.03)
            : isPending
            ? Colors.amber[50]
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDone
              ? Colors.black12
              : isPending
              ? Colors.amber[200]!
              : Colors.black.withOpacity(0.06),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Center(child: badge),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDone
                        ? Colors.black
                        : isPending
                        ? Colors.amber[900]
                        : Colors.black45,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: isDone
                        ? Colors.black54
                        : isPending
                        ? Colors.amber[800]
                        : Colors.black38,
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