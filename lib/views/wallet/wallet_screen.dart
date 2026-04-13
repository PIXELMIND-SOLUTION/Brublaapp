import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.chevron_left,color: Colors.white,)),
          // child: const Icon(Icons.chevron_left, color: Colors.black),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Wallet illustration
                  SizedBox(
                    width: 170,
                    height: 100,
                    child: Image.asset(
                      'assets/wallet.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _WalletIllustration();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Balance info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '₹0',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'No wallet amount\navailable',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4A853),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            child: const Text(
                              'Add Amount',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Details Section
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            // Transaction List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _TransactionTile(
                    icon: Icons.south_west,
                    iconColor: const Color(0xFF6B4EFF),
                    iconBgColor: const Color(0xFFF0ECFF),
                    title: 'Received From',
                    subtitle: 'referral id : #123456',
                    amount: '₹30',
                    amountLabel: 'Credited',
                    amountColor: Colors.green,
                    timeLabel: '1 day ago',
                    showDivider: true,
                  ),
                  _TransactionTile(
                    icon: Icons.north_east,
                    iconColor: const Color(0xFFFF4E4E),
                    iconBgColor: const Color(0xFFFFECEC),
                    title: 'Paid To',
                    subtitle: 'referral id : #123456',
                    amount: '₹30',
                    amountLabel: 'Debit',
                    amountColor: Colors.red,
                    timeLabel: '1 day ago',
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String amount;
  final String amountLabel;
  final Color amountColor;
  final String timeLabel;
  final bool showDivider;

  const _TransactionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountLabel,
    required this.amountColor,
    required this.timeLabel,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon container
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  // Title & subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Amount & label
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        amountLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: amountColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Time label below icon
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  timeLabel,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade100,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

/// Fallback illustration widget if the asset is not found
class _WalletIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Teal blob background
        Positioned(
          top: 0,
          left: 10,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF3DBFA0).withOpacity(0.3),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        // Purple phone shape
        Positioned(
          right: 10,
          top: 5,
          child: Container(
            width: 32,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFF7B5EA7),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        // Brown wallet shape
        Positioned(
          bottom: 5,
          left: 5,
          child: Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF8B5E3C),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        // Gold coin
        Positioned(
          top: 8,
          right: 5,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFFD4A853),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Person silhouette
        const Positioned(
          bottom: 10,
          left: 30,
          child: Icon(Icons.person, color: Color(0xFF3D3D8F), size: 36),
        ),
      ],
    );
  }
}