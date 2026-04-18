// import 'package:flutter/material.dart';

// enum OrderStatus { pending, confirmed, accepted, delivered, cancelled }

// class OrderItem {
//   final String id;
//   final String customerName;
//   final String garmentType;
//   final String imageUrl;
//   final OrderStatus status;
//   final String date;
//   final String price;
//   final String measurements;

//   const OrderItem({
//     required this.id,
//     required this.customerName,
//     required this.garmentType,
//     required this.imageUrl,
//     required this.status,
//     required this.date,
//     required this.price,
//     required this.measurements,
//   });
// }

// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   OrderStatus? _selectedFilter;

//   final List<OrderItem> _orders = const [
//     OrderItem(
//       id: '#TLR-0041',
//       customerName: 'Arjun Menon',
//       garmentType: 'Formal Shirt',
//       imageUrl:
//           'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400&q=80',
//       status: OrderStatus.pending,
//       date: 'Apr 14, 2025',
//       price: '₹850',
//       measurements: 'Chest 40" | Sleeve 25"',
//     ),
//     OrderItem(
//       id: '#TLR-0040',
//       customerName: 'Ravi Kumar',
//       garmentType: 'Slim Trousers',
//       imageUrl:
//           'https://images.unsplash.com/photo-1594938298603-c8148c4b4abe?w=400&q=80',
//       status: OrderStatus.confirmed,
//       date: 'Apr 12, 2025',
//       price: '₹1,200',
//       measurements: 'Waist 32" | Length 42"',
//     ),
//     OrderItem(
//       id: '#TLR-0039',
//       customerName: 'Suresh Nair',
//       garmentType: 'Kurta',
//       imageUrl:
//           'https://images.unsplash.com/photo-1519058082700-08a0b56da9b4?w=400&q=80',
//       status: OrderStatus.accepted,
//       date: 'Apr 10, 2025',
//       price: '₹950',
//       measurements: 'Chest 38" | Length 44"',
//     ),
//     OrderItem(
//       id: '#TLR-0038',
//       customerName: 'Deepak Pillai',
//       garmentType: 'Wedding Sherwani',
//       imageUrl:
//           'https://images.unsplash.com/photo-1607345366928-199ea26cfe3e?w=400&q=80',
//       status: OrderStatus.delivered,
//       date: 'Apr 8, 2025',
//       price: '₹4,500',
//       measurements: 'Chest 42" | Waist 36"',
//     ),
//     OrderItem(
//       id: '#TLR-0037',
//       customerName: 'Anoop George',
//       garmentType: 'Casual Shirt',
//       imageUrl:
//           'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=400&q=80',
//       status: OrderStatus.cancelled,
//       date: 'Apr 5, 2025',
//       price: '₹700',
//       measurements: 'Chest 38" | Sleeve 24"',
//     ),
//     OrderItem(
//       id: '#TLR-0036',
//       customerName: 'Manoj Thomas',
//       garmentType: 'Formal Trousers',
//       imageUrl:
//           'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=400&q=80',
//       status: OrderStatus.confirmed,
//       date: 'Apr 3, 2025',
//       price: '₹1,100',
//       measurements: 'Waist 34" | Length 40"',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   List<OrderItem> get _filteredOrders {
//     if (_selectedFilter == null) return _orders;
//     return _orders.where((o) => o.status == _selectedFilter).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSummaryBanner(),
//           _buildFilterChips(),
//           const SizedBox(height: 4),
//           Expanded(
//             child: _filteredOrders.isEmpty
//                 ? _buildEmptyState()
//                 : ListView.builder(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                     itemCount: _filteredOrders.length,
//                     itemBuilder: (context, index) =>
//                         _buildOrderCard(_filteredOrders[index]),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.black,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       title: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Order History',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//               letterSpacing: 0.5,
//             ),
//           ),
//           Text(
//             'Track all your tailoring orders',
//             style: TextStyle(
//               fontSize: 11,
//               color: Colors.white54,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.search, color: Colors.white),
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.tune_rounded, color: Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryBanner() {
//     final Map<OrderStatus, int> counts = {};
//     for (final status in OrderStatus.values) {
//       counts[status] = _orders.where((o) => o.status == status).length;
//     }

//     return Container(
//       color: Colors.black,
//       padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//       child: Row(
//         children: [
//           _summaryTile('Total', _orders.length.toString(), Colors.white),
//           _summaryDivider(),
//           _summaryTile('Pending', counts[OrderStatus.pending].toString(),
//               Colors.amber.shade300),
//           _summaryDivider(),
//           _summaryTile('Confirmed', counts[OrderStatus.confirmed].toString(),
//               Colors.blue.shade300),
//           _summaryDivider(),
//           _summaryTile('Delivered', counts[OrderStatus.delivered].toString(),
//               Colors.green.shade300),
//         ],
//       ),
//     );
//   }

//   Widget _summaryTile(String label, String value, Color valueColor) {
//     return Expanded(
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: valueColor,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 11,
//               color: Colors.white54,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summaryDivider() {
//     return Container(
//       width: 0.5,
//       height: 32,
//       color: Colors.white24,
//     );
//   }

//   Widget _buildFilterChips() {
//     final filters = [
//       (null, 'All'),
//       (OrderStatus.pending, 'Pending'),
//       (OrderStatus.confirmed, 'Confirmed'),
//       (OrderStatus.accepted, 'Accepted'),
//       (OrderStatus.delivered, 'Delivered'),
//       (OrderStatus.cancelled, 'Cancelled'),
//     ];

//     return Container(
//       height: 52,
//       color: Colors.grey.shade50,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         scrollDirection: Axis.horizontal,
//         itemCount: filters.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           final (status, label) = filters[index];
//           final isSelected = _selectedFilter == status;
//           return GestureDetector(
//             onTap: () => setState(() => _selectedFilter = status),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.black : Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: isSelected ? Colors.black : Colors.grey.shade300,
//                 ),
//               ),
//               child: Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight:
//                       isSelected ? FontWeight.w600 : FontWeight.w400,
//                   color: isSelected ? Colors.white : Colors.black87,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildOrderCard(OrderItem order) {
//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildCardTop(order),
//           _buildCardBottom(order),
//         ],
//       ),
//     );
//   }

//   Widget _buildCardTop(OrderItem order) {
//     return Padding(
//       padding: const EdgeInsets.all(14),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildGarmentImage(order.imageUrl),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       order.garmentType,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                       ),
//                     ),
//                     _buildStatusBadge(order.status),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.person_outline,
//                         size: 13, color: Colors.black54),
//                     const SizedBox(width: 4),
//                     Text(
//                       order.customerName,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.straighten_outlined,
//                         size: 13, color: Colors.black38),
//                     const SizedBox(width: 4),
//                     Text(
//                       order.measurements,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.black38,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGarmentImage(String url) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: SizedBox(
//         width: 80,
//         height: 90,
//         child: Image.network(
//           url,
//           fit: BoxFit.cover,
//           errorBuilder: (_, __, ___) => Container(
//             color: Colors.grey.shade100,
//             child: const Icon(Icons.checkroom_outlined,
//                 color: Colors.black26, size: 32),
//           ),
//           loadingBuilder: (_, child, progress) {
//             if (progress == null) return child;
//             return Container(
//               color: Colors.grey.shade100,
//               child: Center(
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.black26,
//                     value: progress.expectedTotalBytes != null
//                         ? progress.cumulativeBytesLoaded /
//                             progress.expectedTotalBytes!
//                         : null,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusBadge(OrderStatus status) {
//     final config = _statusConfig(status);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: config['bg'] as Color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 6,
//             height: 6,
//             decoration: BoxDecoration(
//               color: config['dot'] as Color,
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 5),
//           Text(
//             config['label'] as String,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: config['text'] as Color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCardBottom(OrderItem order) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.calendar_today_outlined,
//               size: 13, color: Colors.black38),
//           const SizedBox(width: 5),
//           Text(
//             order.date,
//             style: const TextStyle(fontSize: 12, color: Colors.black45),
//           ),
//           const SizedBox(width: 16),
//           const Icon(Icons.tag_outlined, size: 13, color: Colors.black38),
//           const SizedBox(width: 4),
//           Text(
//             order.id,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.black45,
//               fontFamily: 'monospace',
//             ),
//           ),
//           const Spacer(),
//           Text(
//             order.price,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'View',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.receipt_long_outlined,
//                 size: 48, color: Colors.black26),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'No orders found',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 6),
//           const Text(
//             'Orders with this status will appear here',
//             style: TextStyle(fontSize: 13, color: Colors.black38),
//           ),
//         ],
//       ),
//     );
//   }

//   Map<String, dynamic> _statusConfig(OrderStatus status) {
//     switch (status) {
//       case OrderStatus.pending:
//         return {
//           'label': 'Pending',
//           'bg': Colors.amber.shade50,
//           'dot': Colors.amber.shade600,
//           'text': Colors.amber.shade800,
//         };
//       case OrderStatus.confirmed:
//         return {
//           'label': 'Confirmed',
//           'bg': Colors.blue.shade50,
//           'dot': Colors.blue.shade500,
//           'text': Colors.blue.shade800,
//         };
//       case OrderStatus.accepted:
//         return {
//           'label': 'Accepted',
//           'bg': Colors.purple.shade50,
//           'dot': Colors.purple.shade400,
//           'text': Colors.purple.shade800,
//         };
//       case OrderStatus.delivered:
//         return {
//           'label': 'Delivered',
//           'bg': Colors.green.shade50,
//           'dot': Colors.green.shade500,
//           'text': Colors.green.shade800,
//         };
//       case OrderStatus.cancelled:
//         return {
//           'label': 'Cancelled',
//           'bg': Colors.red.shade50,
//           'dot': Colors.red.shade400,
//           'text': Colors.red.shade700,
//         };
//     }
//   }
// }
















import 'package:brublaapp/views/Stylistmodule/home/detail_screen.dart';
import 'package:flutter/material.dart';

enum OrderStatus { pending, confirmed, accepted, delivered, cancelled }

class OrderItem {
  final String id;
  final String customerName;
  final String garmentType;
  final String imageUrl;
  final OrderStatus status;
  final String date;
  final String price;
  final String measurements;

  const OrderItem({
    required this.id,
    required this.customerName,
    required this.garmentType,
    required this.imageUrl,
    required this.status,
    required this.date,
    required this.price,
    required this.measurements,
  });
}

class StylistHistoryScreen extends StatefulWidget {
  const StylistHistoryScreen({super.key});

  @override
  State<StylistHistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<StylistHistoryScreen> {
  OrderStatus? _selectedFilter;

  final List<OrderItem> _orders = const [
    OrderItem(
      id: '#TLR-0041',
      customerName: 'Arjun Menon',
      garmentType: 'Formal Shirt',
      imageUrl:
          'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=400&q=80',
      status: OrderStatus.pending,
      date: 'Apr 14, 2025',
      price: '₹850',
      measurements: 'Chest 40" | Sleeve 25"',
    ),
    OrderItem(
      id: '#TLR-0040',
      customerName: 'Ravi Kumar',
      garmentType: 'Slim Trousers',
      imageUrl:
          'https://images.unsplash.com/photo-1594938298603-c8148c4b4abe?w=400&q=80',
      status: OrderStatus.confirmed,
      date: 'Apr 12, 2025',
      price: '₹1,200',
      measurements: 'Waist 32" | Length 42"',
    ),
    OrderItem(
      id: '#TLR-0039',
      customerName: 'Suresh Nair',
      garmentType: 'Kurta',
      imageUrl:
          'https://images.unsplash.com/photo-1519058082700-08a0b56da9b4?w=400&q=80',
      status: OrderStatus.accepted,
      date: 'Apr 10, 2025',
      price: '₹950',
      measurements: 'Chest 38" | Length 44"',
    ),
    OrderItem(
      id: '#TLR-0038',
      customerName: 'Deepak Pillai',
      garmentType: 'Wedding Sherwani',
      imageUrl:
          'https://images.unsplash.com/photo-1607345366928-199ea26cfe3e?w=400&q=80',
      status: OrderStatus.delivered,
      date: 'Apr 8, 2025',
      price: '₹4,500',
      measurements: 'Chest 42" | Waist 36"',
    ),
    OrderItem(
      id: '#TLR-0037',
      customerName: 'Anoop George',
      garmentType: 'Casual Shirt',
      imageUrl:
          'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=400&q=80',
      status: OrderStatus.cancelled,
      date: 'Apr 5, 2025',
      price: '₹700',
      measurements: 'Chest 38" | Sleeve 24"',
    ),
    OrderItem(
      id: '#TLR-0036',
      customerName: 'Manoj Thomas',
      garmentType: 'Formal Trousers',
      imageUrl:
          'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=400&q=80',
      status: OrderStatus.confirmed,
      date: 'Apr 3, 2025',
      price: '₹1,100',
      measurements: 'Waist 34" | Length 40"',
    ),
  ];

  List<OrderItem> get _filteredOrders {
    if (_selectedFilter == null) return _orders;
    return _orders.where((o) => o.status == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom AppBar
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order History',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.1,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 4),
                  // Text(
                  //   'Track your tailoring journey',
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //     color: Colors.white70,
                  //   ),
                  // ),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_outlined),
              ),
            ],
          ),
          
          // Stats Cards
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Row(
                  children: [
                    _buildStatCard('Total', _orders.length.toString(), Icons.receipt_long, Colors.white),
                    const SizedBox(width: 12),
                    _buildStatCard('Pending', _orders.where((o) => o.status == OrderStatus.pending).length.toString(), Icons.schedule, Colors.amber.shade300),
                    const SizedBox(width: 12),
                    _buildStatCard('Completed', _orders.where((o) => o.status == OrderStatus.delivered).length.toString(), Icons.check_circle, Colors.green.shade300),
                  ],
                ),
              ),
            ),
          ),
          
          // Filter Tabs
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 45,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: [
                    (null, 'All Orders'),
                    (OrderStatus.pending, 'Pending'),
                    (OrderStatus.confirmed, 'Confirmed'),
                    (OrderStatus.accepted, 'Accepted'),
                    (OrderStatus.delivered, 'Delivered'),
                    (OrderStatus.cancelled, 'Cancelled'),
                  ].length,
                  itemBuilder: (context, index) {
                    final filters = [
                      (null, 'All Orders'),
                      (OrderStatus.pending, 'Pending'),
                      (OrderStatus.confirmed, 'Confirmed'),
                      (OrderStatus.accepted, 'Accepted'),
                      (OrderStatus.delivered, 'Delivered'),
                      (OrderStatus.cancelled, 'Cancelled'),
                    ];
                    final (status, label) = filters[index];
                    final isSelected = _selectedFilter == status;
                    
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = status),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          // Orders List
          _filteredOrders.isEmpty
              ? SliverFillRemaining(
                  child: _buildEmptyState(),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildModernOrderCard(_filteredOrders[index]),
                    childCount: _filteredOrders.length,
                  ),
                ),
          
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: valueColor),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernOrderCard(OrderItem order) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with ID and Status
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order.id,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildModernStatusBadge(order.status),
                  ],
                ),
                Text(
                  order.date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      order.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.checkroom, size: 40, color: Colors.grey),
                      ),
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.garmentType,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            order.customerName,
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.straighten, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            order.measurements,
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DesignerProductDetailScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatusBadge(OrderStatus status) {
    final config = _statusConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (config['bg'] as Color).withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            size: 12,
            color: config['dot'] as Color,
          ),
          const SizedBox(width: 4),
          Text(
            config['label'] as String,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: config['text'] as Color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.access_time;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.accepted:
        return Icons.thumb_up_outlined;
      case OrderStatus.delivered:
        return Icons.local_shipping;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey.shade100, Colors.grey.shade50],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inbox_outlined,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No orders found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No orders with this status yet',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _statusConfig(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return {
          'label': 'Pending',
          'bg': Colors.amber,
          'dot': Colors.amber.shade700,
          'text': Colors.amber.shade800,
        };
      case OrderStatus.confirmed:
        return {
          'label': 'Confirmed',
          'bg': Colors.blue,
          'dot': Colors.blue.shade700,
          'text': Colors.blue.shade800,
        };
      case OrderStatus.accepted:
        return {
          'label': 'Accepted',
          'bg': Colors.purple,
          'dot': Colors.purple.shade700,
          'text': Colors.purple.shade800,
        };
      case OrderStatus.delivered:
        return {
          'label': 'Delivered',
          'bg': Colors.green,
          'dot': Colors.green.shade700,
          'text': Colors.green.shade800,
        };
      case OrderStatus.cancelled:
        return {
          'label': 'Cancelled',
          'bg': Colors.red,
          'dot': Colors.red.shade700,
          'text': Colors.red.shade800,
        };
    }
  }
}