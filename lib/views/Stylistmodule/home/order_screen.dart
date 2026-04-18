
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedTabIndex = 0; // 0: All, 1: In Progress, 2: Completed, 3: Cancelled

  final List<OrderItem> _allOrders = [
    OrderItem(
      productName: 'Floral Summer Dress',
      designer: 'Elena Fashion House',
      price: '\$129.00',
      status: 'In Progress',
      statusColor: Colors.amber,
      imageAsset: 'assets/dress1.png', // Use actual asset path
      imageIcon: '👗',
      orderNumber: '#ORD-2341',
      date: 'Dec 15, 2024',
      size: 'M',
      color: 'Red Floral',
    ),
    OrderItem(
      productName: 'Elegant Evening Gown',
      designer: 'Vera Couture',
      price: '\$399.00',
      status: 'Completed',
      statusColor: Colors.green,
      imageAsset: 'assets/dress2.png',
      imageIcon: '👘',
      orderNumber: '#ORD-2342',
      date: 'Dec 10, 2024',
      size: 'S',
      color: 'Navy Blue',
    ),
    OrderItem(
      productName: 'Casual Linen Dress',
      designer: 'Urban Stitch',
      price: '\$89.00',
      status: 'Completed',
      statusColor: Colors.green,
      imageAsset: 'assets/dress3.png',
      imageIcon: '🥻',
      orderNumber: '#ORD-2343',
      date: 'Dec 05, 2024',
      size: 'L',
      color: 'Beige',
    ),
    OrderItem(
      productName: 'Party Wear Sequins',
      designer: 'Glamour Studios',
      price: '\$249.00',
      status: 'Cancelled',
      statusColor: Colors.red,
      imageAsset: 'assets/dress4.png',
      imageIcon: '✨👗',
      orderNumber: '#ORD-2344',
      date: 'Nov 28, 2024',
      size: 'XS',
      color: 'Gold',
    ),
    OrderItem(
      productName: 'Bohemian Maxi Dress',
      designer: 'Free Spirit Fashion',
      price: '\$159.00',
      status: 'In Progress',
      statusColor: Colors.amber,
      imageAsset: 'assets/dress5.png',
      imageIcon: '🌺👗',
      orderNumber: '#ORD-2345',
      date: 'Dec 12, 2024',
      size: 'XL',
      color: 'Printed',
    ),
    OrderItem(
      productName: 'Office Tailored Dress',
      designer: 'Professional Chic',
      price: '\$179.00',
      status: 'Completed',
      statusColor: Colors.green,
      imageAsset: 'assets/dress6.png',
      imageIcon: '👔',
      orderNumber: '#ORD-2346',
      date: 'Dec 08, 2024',
      size: 'M',
      color: 'Black',
    ),
    OrderItem(
      productName: 'Beach Cover-up Dress',
      designer: 'Tropical Waves',
      price: '\$69.00',
      status: 'Cancelled',
      statusColor: Colors.red,
      imageAsset: 'assets/dress7.png',
      imageIcon: '🏖️👗',
      orderNumber: '#ORD-2347',
      date: 'Nov 30, 2024',
      size: 'S',
      color: 'Turquoise',
    ),
  ];

  List<OrderItem> get _filteredOrders {
    switch (_selectedTabIndex) {
      case 0: // All
        return _allOrders;
      case 1: // In Progress
        return _allOrders.where((order) => order.status == 'In Progress').toList();
      case 2: // Completed
        return _allOrders.where((order) => order.status == 'Completed').toList();
      case 3: // Cancelled
        return _allOrders.where((order) => order.status == 'Cancelled').toList();
      default:
        return _allOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search, color: Colors.white),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.filter_list, color: Colors.white),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Order Status Tabs - Now Working
          Container(
            height: 48,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                _buildOrderStatusTab('All', 0),
                _buildOrderStatusTab('In Progress', 1),
                _buildOrderStatusTab('Completed', 2),
                _buildOrderStatusTab('Cancelled', 3),
              ],
            ),
          ),
          
          // Order List
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No orders found',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderItem(_filteredOrders[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItem order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Image and basic info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dress Image Container
                    Container(
                      width: 90,
                      height: 110,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey, Colors.white54],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey[700]!,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          order.imageIcon,
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.productName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 14,
                                color: Colors.white54,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  order.designer,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Size: ${order.size}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  order.color,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order.price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Divider
                Container(
                  height: 1,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 12),
                
                // Order details row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.orderNumber,
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: Colors.white38,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              order.date,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: order.statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: order.statusColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: order.statusColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            order.status,
                            style: TextStyle(
                              color: order.statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Track order action
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tracking ${order.orderNumber}'),
                              backgroundColor: Colors.grey[800],
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[700]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: const Text(
                          'Track Order',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // View details action
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Details for ${order.orderNumber}'),
                              backgroundColor: Colors.grey[800],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItem {
  final String productName;
  final String designer;
  final String price;
  final String status;
  final Color statusColor;
  final String imageAsset;
  final String imageIcon;
  final String orderNumber;
  final String date;
  final String size;
  final String color;

  OrderItem({
    required this.productName,
    required this.designer,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.imageAsset,
    required this.imageIcon,
    required this.orderNumber,
    required this.date,
    required this.size,
    required this.color,
  });
}