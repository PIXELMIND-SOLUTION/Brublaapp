// import 'package:brublaapp/views/home/stylist_screen.dart';
// import 'package:flutter/material.dart';

// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<String> _tabs = ['All', 'Pending', 'Rejected', 'Cancelled'];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _tabs.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   // ── Sample order data ────────────────────────────────────────────────────────
//   final List<Map<String, dynamic>> _orders = [
//     {
//       'id': '#BRB-10421',
//       'name': 'Wireless Noise-Cancelling Headphones',
//       'price': '\$129.99',
//       'date': 'Mar 28, 2025',
//       'status': 'Pending',
//       'image':
//           'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=200&q=80',
//       'quantity': 1,
//       'eta': 'Apr 3, 2025',
//     },
//     {
//       'id': '#BRB-10398',
//       'name': 'Premium Leather Sneakers',
//       'price': '\$89.00',
//       'date': 'Mar 20, 2025',
//       'status': 'Rejected',
//       'image':
//           'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200&q=80',
//       'quantity': 2,
//       'reason': 'Out of stock in your size',
//     },
//     {
//       'id': '#BRB-10375',
//       'name': 'Smart Watch Series X',
//       'price': '\$249.00',
//       'date': 'Mar 15, 2025',
//       'status': 'Cancelled',
//       'image':
//           'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=200&q=80',
//       'quantity': 1,
//       'reason': 'Cancelled by user',
//     },
//     {
//       'id': '#BRB-10350',
//       'name': 'Minimalist Backpack',
//       'price': '\$64.50',
//       'date': 'Mar 10, 2025',
//       'status': 'Pending',
//       'image':
//           'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=200&q=80',
//       'quantity': 1,
//       'eta': 'Mar 30, 2025',
//     },
//     {
//       'id': '#BRB-10312',
//       'name': 'Ceramic Coffee Mug Set',
//       'price': '\$34.99',
//       'date': 'Mar 5, 2025',
//       'status': 'Rejected',
//       'image':
//           'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=200&q=80',
//       'quantity': 3,
//       'reason': 'Payment declined',
//     },
//     {
//       'id': '#BRB-10290',
//       'name': 'Portable Bluetooth Speaker',
//       'price': '\$79.99',
//       'date': 'Feb 28, 2025',
//       'status': 'Cancelled',
//       'image':
//           'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=200&q=80',
//       'quantity': 1,
//       'reason': 'Better deal found',
//     },
//   ];

//   List<Map<String, dynamic>> get _filteredOrders {
//     final tab = _tabs[_tabController.index];
//     if (tab == 'All') return _orders;
//     return _orders.where((o) => o['status'] == tab).toList();
//   }

//   // ── Status helpers ────────────────────────────────────────────────────────────
//   Color _statusColor(String status) {
//     switch (status) {
//       case 'Pending':
//         return const Color(0xFFF59E0B);
//       case 'Rejected':
//         return const Color(0xFFEF4444);
//       case 'Cancelled':
//         return const Color(0xFF6B7280);
//       default:
//         return const Color(0xFF6B7280);
//     }
//   }

//   IconData _statusIcon(String status) {
//     switch (status) {
//       case 'Pending':
//         return Icons.access_time_rounded;
//       case 'Rejected':
//         return Icons.cancel_rounded;
//       case 'Cancelled':
//         return Icons.remove_circle_rounded;
//       default:
//         return Icons.info_rounded;
//     }
//   }

//   // ── Proceed popup → then navigate ────────────────────────────────────────────
//   void _showProceedDialog(Map<String, dynamic> order) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (ctx) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//         backgroundColor: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Icon badge
//               Container(
//                 width: 64,
//                 height: 64,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFF7ED),
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: const Color(0xFFF97316).withOpacity(0.3),
//                     width: 2,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.shopping_bag_rounded,
//                   color: Color(0xFFF97316),
//                   size: 30,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Proceed with Order?',
//                 style: TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF111827),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'You\'re about to reorder\n${order['name']}',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF6B7280),
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Order summary card
//               Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF9FAFB),
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         order['image'],
//                         width: 52,
//                         height: 52,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) => Container(
//                           width: 52,
//                           height: 52,
//                           color: const Color(0xFFE5E7EB),
//                           child: const Icon(
//                             Icons.image_not_supported_rounded,
//                             color: Color(0xFF9CA3AF),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             order['name'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF111827),
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Qty: ${order['quantity']}  •  ${order['price']}',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF6B7280),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(ctx),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         side: const BorderSide(color: Color(0xFFE5E7EB)),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Cancel',
//                         style: TextStyle(
//                           color: Color(0xFF374151),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Close the dialog first, then navigate
//                         Navigator.pop(ctx);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => StylistScreen(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF97316),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Proceed',
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ── UI ────────────────────────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F6),
//             // backgroundColor: const Color.fromARGB(255, 0, 0, 0),

//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//                 // backgroundColor: const Color.fromARGB(255, 0, 0, 0),

//         elevation: 0,
//         centerTitle: false,
//         title: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order History',
//               style: TextStyle(
//                 fontFamily: 'Georgia',
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Color.fromARGB(255, 0, 0, 0),
//               ),
//             ),
//             Text(
//               'Brubla Store',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 0.5,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.filter_list_rounded,
//               color: Color(0xFF374151),
//             ),
//             onPressed: () {},
//           ),
//           const SizedBox(width: 4),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: TabBar(
//             controller: _tabController,
//             labelColor: const Color.fromARGB(255, 0, 0, 0),
//             unselectedLabelColor: const Color(0xFF6B7280),
//             indicatorColor: const Color(0xFFF97316),
//             indicatorWeight: 3,
//             labelStyle: const TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 13,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 13,
//             ),
//             tabs: _tabs.map((t) => Tab(text: t)).toList(),
//             onTap: (_) => setState(() {}),
//           ),
//         ),
//       ),
//       body: AnimatedBuilder(
//         animation: _tabController,
//         builder: (context, _) {
//           final orders = _filteredOrders;
//           if (orders.isEmpty) {
//             return _buildEmptyState();
//           }
//           return ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: orders.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 12),
//             itemBuilder: (ctx, i) => _OrderCard(
//               order: orders[i],
//               statusColor: _statusColor(orders[i]['status']),
//               statusIcon: _statusIcon(orders[i]['status']),
//               // Pass the dialog callback — no direct navigation from the card
//               onProceed: () => _showProceedDialog(orders[i]),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             decoration: const BoxDecoration(
//               color: Color(0xFFFFF7ED),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.receipt_long_rounded,
//               color: Color(0xFFF97316),
//               size: 46,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'No orders found',
//             style: TextStyle(
//               fontFamily: 'Georgia',
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF111827),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Your order history will appear here.',
//             style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Order Card ────────────────────────────────────────────────────────────────
// class _OrderCard extends StatelessWidget {
//   final Map<String, dynamic> order;
//   final Color statusColor;
//   final IconData statusIcon;
//   final VoidCallback onProceed;

//   const _OrderCard({
//     required this.order,
//     required this.statusColor,
//     required this.statusIcon,
//     required this.onProceed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final status = order['status'] as String;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Top row: Order ID + Status badge ──────────────────────────────
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   order['id'],
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF374151),
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: statusColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(statusIcon, color: statusColor, size: 13),
//                       const SizedBox(width: 4),
//                       Text(
//                         status,
//                         style: TextStyle(
//                           color: statusColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 14),

//             // ── Product row ────────────────────────────────────────────────────
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     order['image'],
//                     width: 72,
//                     height: 72,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       width: 72,
//                       height: 72,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF3F4F6),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.image_rounded,
//                         color: Color(0xFF9CA3AF),
//                         size: 32,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         order['name'],
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF111827),
//                           height: 1.3,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Text(
//                             order['price'],
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w800,
//                               color: Color(0xFFF97316),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             'Qty: ${order['quantity']}',
//                             style: const TextStyle(
//                               fontSize: 13,
//                               color: Color(0xFF9CA3AF),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 14),
//             const Divider(color: Color(0xFFF3F4F6), height: 1),
//             const SizedBox(height: 12),

//             // ── Bottom row: date/reason + Proceed button ─────────────────────
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.calendar_today_rounded,
//                           size: 12,
//                           color: Color(0xFF9CA3AF),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           order['date'],
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Color(0xFF9CA3AF),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (order.containsKey('eta')) ...[
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.local_shipping_rounded,
//                             size: 12,
//                             color: Color(0xFFF59E0B),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             'ETA: ${order['eta']}',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFFF59E0B),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                     if (order.containsKey('reason')) ...[
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.info_outline_rounded,
//                             size: 12,
//                             color: statusColor,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             order['reason'],
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: statusColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//                 // Proceed button now calls onProceed (shows popup → navigates)
//                 GestureDetector(
//                   onTap: onProceed,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 0, 0)],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFFF97316).withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: const Text(
//                       'Proceed',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
























import 'package:brublaapp/views/home/stylist_screen.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = [
    'All',
    'Pending',
    'Rejected',
    'Cancelled',
  ];

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': '#BRB-10421',
      'name': 'Wireless Noise-Cancelling Headphones',
      'price': '\$129.99',
      'date': 'Mar 28, 2025',
      'status': 'Pending',
      'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=200&q=80',
      'quantity': 1,
      'eta': 'Apr 3, 2025',
    },
    {
      'id': '#BRB-10398',
      'name': 'Premium Leather Sneakers',
      'price': '\$89.00',
      'date': 'Mar 20, 2025',
      'status': 'Rejected',
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200&q=80',
      'quantity': 2,
      'reason': 'Out of stock in your size',
    },
    {
      'id': '#BRB-10375',
      'name': 'Smart Watch Series X',
      'price': '\$249.00',
      'date': 'Mar 15, 2025',
      'status': 'Cancelled',
      'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=200&q=80',
      'quantity': 1,
      'reason': 'Cancelled by user',
    },
    {
      'id': '#BRB-10350',
      'name': 'Minimalist Backpack',
      'price': '\$64.50',
      'date': 'Mar 10, 2025',
      'status': 'Pending',
      'image':
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=200&q=80',
      'quantity': 1,
      'eta': 'Mar 30, 2025',
    },
    {
      'id': '#BRB-10312',
      'name': 'Ceramic Coffee Mug Set',
      'price': '\$34.99',
      'date': 'Mar 5, 2025',
      'status': 'Rejected',
      'image':
          'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=200&q=80',
      'quantity': 3,
      'reason': 'Payment declined',
    },
    {
      'id': '#BRB-10290',
      'name': 'Portable Bluetooth Speaker',
      'price': '\$79.99',
      'date': 'Feb 28, 2025',
      'status': 'Cancelled',
      'image':
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=200&q=80',
      'quantity': 1,
      'reason': 'Better deal found',
    },
  ];

  List<Map<String, dynamic>> get _filteredBookings {
    if (_selectedFilter == 'All') return _bookings;
    return _bookings
        .where((b) => b['status'] == _selectedFilter)
        .toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFF59E0B);
      case 'Rejected':
        return const Color(0xFFEF4444);
      case 'Cancelled':
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.access_time_rounded;
      case 'Rejected':
        return Icons.cancel_rounded;
      case 'Cancelled':
        return Icons.remove_circle_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  // ── Filter bottom sheet ───────────────────────────────────────────────────────
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Filter by Status',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Select a status to filter your bookings',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Filter options
                  ..._filterOptions.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    Color chipColor;
                    IconData chipIcon;
                    switch (filter) {
                      case 'Pending':
                        chipColor = const Color(0xFFF59E0B);
                        chipIcon = Icons.access_time_rounded;
                        break;
                      case 'Rejected':
                        chipColor = const Color(0xFFEF4444);
                        chipIcon = Icons.cancel_rounded;
                        break;
                      case 'Cancelled':
                        chipColor = const Color(0xFF6B7280);
                        chipIcon = Icons.remove_circle_rounded;
                        break;
                      default:
                        chipColor = const Color(0xFF111827);
                        chipIcon = Icons.list_rounded;
                    }
                    return GestureDetector(
                      onTap: () {
                        setSheetState(() {});
                        setState(() => _selectedFilter = filter);
                        Navigator.pop(ctx);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? chipColor.withOpacity(0.08)
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? chipColor
                                : const Color(0xFFE5E7EB),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: chipColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                chipIcon,
                                color: chipColor,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                filter == 'All'
                                    ? 'All Bookings'
                                    : filter,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? chipColor
                                      : const Color(0xFF374151),
                                ),
                              ),
                            ),
                            if (filter != 'All') ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: chipColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${_bookings.where((b) => b['status'] == filter).length}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: chipColor,
                                  ),
                                ),
                              ),
                            ] else ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF111827).withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${_bookings.length}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(width: 8),
                            Icon(
                              isSelected
                                  ? Icons.check_circle_rounded
                                  : Icons.circle_outlined,
                              color: isSelected
                                  ? chipColor
                                  : const Color(0xFFD1D5DB),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final filtered = _filteredBookings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Bookings',
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
            Row(
              children: [
                const Text(
                  'Brubla Store',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                if (_selectedFilter != 'All') ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111827),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _selectedFilter,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.filter_list_rounded,
                  color: Color(0xFF374151),
                ),
                onPressed: _showFilterSheet,
              ),
              if (_selectedFilter != 'All')
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF97316),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      // ── Body + sticky bottom button using Column ──────────────────────────────
      body: Column(
        children: [
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) => _BookingCard(
                      booking: filtered[i],
                      statusColor: _statusColor(filtered[i]['status']),
                      statusIcon: _statusIcon(filtered[i]['status']),
                    ),
                  ),
          ),
          // ── Create Stylist button — always visible ────────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
              16,
              12,
              16,
              MediaQuery.of(context).padding.bottom + 12,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StylistScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  'Create Stylist',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF7ED),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Color(0xFFF97316),
              size: 46,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No bookings found',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter == 'All'
                ? 'Your recent bookings will appear here.'
                : 'No $_selectedFilter bookings found.',
            style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}

// ── Booking Card ──────────────────────────────────────────────────────────────
class _BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final Color statusColor;
  final IconData statusIcon;

  const _BookingCard({
    required this.booking,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    final status = booking['status'] as String;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row ───────────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking['id'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF374151),
                    letterSpacing: 0.3,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: statusColor, size: 13),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Product row ───────────────────────────────────────────────────
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    booking['image'],
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.image_rounded,
                        color: Color(0xFF9CA3AF),
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            booking['price'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFF97316),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Qty: ${booking['quantity']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            const Divider(color: Color(0xFFF3F4F6), height: 1),
            const SizedBox(height: 12),

            // ── Bottom info row ───────────────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                if (booking.containsKey('eta')) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_shipping_rounded,
                        size: 12,
                        color: Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'ETA: ${booking['eta']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFF59E0B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (booking.containsKey('reason')) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 12,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        booking['reason'],
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}