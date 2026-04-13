import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: const Text(
          'Payment Details',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1, color: Color(0xFFE0E0E0)),

            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: const AssetImage('assets/profile.png'),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Narasimha varma',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '9666317749',
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(221, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE0E0E0)),

            // Booking Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _buildDetailRow(
                    'Reason For Booking',
                    'Marriage',
                    isBold: true,
                  ),
                  const SizedBox(height: 14),
                  _buildDetailRow('Location', 'Kphb, Hyderabad,\nKukatpally'),
                  const SizedBox(height: 14),
                  _buildDetailRow('Date', '12/03/2026'),
                  const SizedBox(height: 14),
                  _buildDetailRow('Time', '10:00 AM – 12:00 PM'),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE0E0E0)),

            // Apply Coupon
            Container(
              color: const Color(0xFFFDF6EE),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.percent, size: 18, color: Colors.black54),
                      SizedBox(width: 8),
                      Text(
                        'Apply Coupon',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                  const Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD4813A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE0E0E0)),

            // Order Payment Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Payment Details',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildPaymentRow(
                    'Order Amount',
                    '\$200',
                    valueColor: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentRow(
                    'Order Saving',
                    '- \$200',
                    valueColor: const Color(0xFF2ECC71),
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentRow(
                    'Delivery Fee',
                    'Free',
                    valueColor: const Color(0xFFD4813A),
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentRow(
                    'Platorm Fee',
                    'Free',
                    valueColor: const Color(0xFFD4813A),
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFE0E0E0)),
                  const SizedBox(height: 14),
                  _buildPaymentRow(
                    'Order Total',
                    '\$200',
                    labelBold: true,
                    valueColor: Colors.black,
                    valueBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Processing Payment!..'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4A96A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Proceed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: const Color.fromARGB(221, 255, 255, 255),
            ),
          ),
        ),
        const Text(': ', style: TextStyle(fontSize: 14, color: Color.fromARGB(221, 255, 255, 255))),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: const Color.fromARGB(221, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value, {
    Color valueColor = Colors.black,
    bool labelBold = false,
    bool valueBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: const Color.fromARGB(221, 255, 255, 255),
            fontWeight: labelBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor,
            fontWeight: valueBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
