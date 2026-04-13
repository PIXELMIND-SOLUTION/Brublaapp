import 'package:flutter/material.dart';

class ExclusiveScreen extends StatelessWidget {
  const ExclusiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        // automaticallyImplyLeading: false,
        title: const Text(
          'Plan',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),

            // Crown Icon Image
            Image.asset(
              'assets/planimage.png',
              width: 72,
              height: 72,
            ),

            const SizedBox(height: 14),

            // Brubla
            const Text(
              'Brubla',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),

            // Platinum
            const Text(
              'Platinum',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),

            const SizedBox(height: 6),

            // Membership Till
            const Text(
              'Membership Till 10 November 2024',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(221, 250, 250, 250),
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 24),

            // Your Benefits Section
            _SectionCard(
              title: '✦ Your Benefits ✦',
              children: const [
                _BenefitItem(text: 'High World Limit for  Questions & answers'),
                _BenefitItem(text: 'Unlimited Questions & answers'),
                _BenefitItem(text: 'High World Limit for  Questions & answers'),
                _BenefitItem(text: 'Unlimited Questions & answers'),
              ],
            ),

            const SizedBox(height: 20),

            // Previous Subscriptions Section
            _SectionCard(
              title: '✦ Previous Subscriptions ✦',
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/planimage.png',
                      width: 44,
                      height: 44,
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brubla Platinum',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Starts : 10 October 2023',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        Text(
                          'Ends : 10 October 2024',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _BenefitItem(text: 'Unlimited Questions & answers'),
                const _BenefitItem(text: 'Unlimited Questions & answers'),
                const _BenefitItem(text: 'Unlimited Questions & answers'),
                const _BenefitItem(text: 'Unlimited Questions & answers'),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '28 October 2023 At 4:00PM',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.download, size: 20, color: Colors.black),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                children: _parseText(text),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _parseText(String text) {
    final boldWords = ['Unlimited', 'High'];
    for (final word in boldWords) {
      if (text.startsWith(word)) {
        final rest = text.substring(word.length);
        return [
          TextSpan(
            text: word,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: rest),
        ];
      }
    }
    return [TextSpan(text: text)];
  }
}