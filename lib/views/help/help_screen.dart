// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HelpScreen extends StatefulWidget {
//   const HelpScreen({super.key});

//   @override
//   State<HelpScreen> createState() => _HelpScreenState();
// }

// class _HelpScreenState extends State<HelpScreen> {
//   int? _expandedIndex;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   // ── Brand colours ──────────────────────────────────────────────────────────
//   static const Color _primary = Color(0xFF1A1A2E);
//   static const Color _accent = Color(0xFFE94560);
//   static const Color _surface = Color(0xFFF8F9FD);
//   static const Color _card = Color(0xFFFFFFFF);
//   static const Color _textPrimary = Color(0xFF1A1A2E);
//   static const Color _textSecondary = Color(0xFF6B7280);
//   static const Color _divider = Color(0xFFE5E7EB);





//   Future<void> _launchEmail(String email) async {
//   final Uri emailUri = Uri(
//     scheme: 'mailto',
//     path: email,
//   );

//   if (await canLaunchUrl(emailUri)) {
//     await launchUrl(emailUri);
//   }
// }

// Future<void> _launchPhone(String phone) async {
//   final Uri phoneUri = Uri(
//     scheme: 'tel',
//     path: phone,
//   );

//   if (await canLaunchUrl(phoneUri)) {
//     await launchUrl(phoneUri);
//   }
// }

//   // ── FAQ data ────────────────────────────────────────────────────────────────
//   final List<Map<String, String>> _faqs = [
//     {
//       'q': 'How do I track my order?',
//       'a':
//           'Go to My Orders in your profile tab. Tap any order to see real-time tracking, estimated delivery date, and courier details.',
//     },
//     {
//       'q': 'What is Brubla\'s return policy?',
//       'a':
//           'You can return most items within 30 days of delivery. Items must be unused, in original packaging. Head to Orders → Return Item to start the process.',
//     },
//     {
//       'q': 'How do I apply a promo code?',
//       'a':
//           'On the checkout screen, tap "Add Promo Code" below your order summary. Enter your code and tap Apply. Eligible discounts are applied instantly.',
//     },
//     {
//       'q': 'Can I change or cancel my order?',
//       'a':
//           'Orders can be modified or cancelled within 1 hour of placement. After that, the order enters fulfilment and changes are no longer possible.',
//     },
//     {
//       'q': 'Which payment methods are accepted?',
//       'a':
//           'We accept Visa, Mastercard, American Express, UPI, Net Banking, and Brubla Wallet. All transactions are encrypted with 256-bit SSL.',
//     },
//     {
//       'q': 'How do I update my delivery address?',
//       'a':
//           'Go to Profile → Saved Addresses. You can add, edit or delete addresses. To change the address on a placed order, contact support immediately.',
//     },
//   ];

//   List<Map<String, String>> get _filteredFaqs {
//     if (_searchQuery.isEmpty) return _faqs;
//     return _faqs
//         .where((f) =>
//             f['q']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//             f['a']!.toLowerCase().contains(_searchQuery.toLowerCase()))
//         .toList();
//   }

//   // ── Support channel data ────────────────────────────────────────────────────
//   final List<Map<String, dynamic>> _channels = [
//     // {
//     //   'icon': Icons.chat_bubble_rounded,
//     //   'label': 'Live Chat',
//     //   'sub': 'Avg. reply in 2 min',
//     //   'color': Color(0xFF6366F1),
//     //   'available': true,
//     // },
//     {
//       'icon': Icons.email_rounded,
//       'label': 'Email Us',
//       'sub': 'support@brubla.com',
//       'color': Color(0xFF10B981),
//       'available': true,
//     },
//     {
//       'icon': Icons.phone_rounded,
//       'label': 'Call Us',
//       'sub': 'Mon–Sat, 9 AM–7 PM',
//       'color': Color(0xFFF59E0B),
//       'available': false,
//     },
//   ];

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _surface,
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           // ── App Bar ──────────────────────────────────────────────────────
//           SliverAppBar(
//             expandedHeight: 180,
//             pinned: true,
//             backgroundColor: _primary,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                   color: Colors.white, size: 20),
//               onPressed: () => Navigator.maybePop(context),
//             ),
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.parallax,
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Decorative circles
//                   Positioned(
//                     top: -30,
//                     right: -30,
//                     child: Container(
//                       width: 180,
//                       height: 180,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _accent.withOpacity(0.15),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -40,
//                     left: 60,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.05),
//                       ),
//                     ),
//                   ),
//                   // Content
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: _accent,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: const Icon(Icons.headset_mic_rounded,
//                                   color: Colors.white, size: 20),
//                             ),
//                             const SizedBox(width: 12),
//                             const Text(
//                               'Help Center',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w800,
//                                 letterSpacing: -0.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'How can we help you today?',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.65),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ── Search bar ───────────────────────────────────────────────────
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _card,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: (v) => setState(() => _searchQuery = v),
//                   style: const TextStyle(
//                       color: _textPrimary,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500),
//                   decoration: InputDecoration(
//                     hintText: 'Search FAQs…',
//                     hintStyle: const TextStyle(
//                         color: _textSecondary, fontWeight: FontWeight.w400),
//                     prefixIcon: const Icon(Icons.search_rounded,
//                         color: _textSecondary, size: 22),
//                     suffixIcon: _searchQuery.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.close_rounded,
//                                 color: _textSecondary, size: 20),
//                             onPressed: () {
//                               _searchController.clear();
//                               setState(() => _searchQuery = '');
//                             },
//                           )
//                         : null,
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // ── Contact channels ─────────────────────────────────────────────
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('Contact Support'),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: _channels
//                         .map((ch) => Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: ch == _channels.last ? 0 : 10,
//                                 ),
//                                 child: _ChannelCard(channel: ch),
//                               ),
//                             ))
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ── Quick links ──────────────────────────────────────────────────
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _sectionTitle('Quick Links'),
//                   const SizedBox(height: 12),
//                   _QuickLinkRow(items: const [
//                     _QuickLink(
//                         icon: Icons.local_shipping_rounded,
//                         label: 'Track Order',
//                         color: Color(0xFF6366F1)),
//                     _QuickLink(
//                         icon: Icons.assignment_return_rounded,
//                         label: 'Returns',
//                         color: Color(0xFFE94560)),
//                     _QuickLink(
//                         icon: Icons.account_balance_wallet_rounded,
//                         label: 'Payments',
//                         color: Color(0xFF10B981)),
//                     _QuickLink(
//                         icon: Icons.star_rounded,
//                         label: 'Reviews',
//                         color: Color(0xFFF59E0B)),
//                   ]),
//                 ],
//               ),
//             ),
//           ),

//           // ── FAQ section ──────────────────────────────────────────────────
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
//               child: _sectionTitle('Frequently Asked Questions'),
//             ),
//           ),

//           if (_filteredFaqs.isEmpty)
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(32),
//                 child: Column(
//                   children: [
//                     Icon(Icons.search_off_rounded,
//                         size: 48, color: _textSecondary.withOpacity(0.5)),
//                     const SizedBox(height: 12),
//                     Text('No results for "$_searchQuery"',
//                         style: const TextStyle(
//                             color: _textSecondary, fontSize: 14)),
//                   ],
//                 ),
//               ),
//             )
//           else
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final faq = _filteredFaqs[index];
//                   final isExpanded = _expandedIndex == index;
//                   return Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                     child: _FaqTile(
//                       question: faq['q']!,
//                       answer: faq['a']!,
//                       isExpanded: isExpanded,
//                       onTap: () => setState(() =>
//                           _expandedIndex = isExpanded ? null : index),
//                     ),
//                   );
//                 },
//                 childCount: _filteredFaqs.length,
//               ),
//             ),

//           // ── Footer ───────────────────────────────────────────────────────
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 32, 16, 40),
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [_primary, Color(0xFF16213E)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: _accent.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(Icons.feedback_rounded,
//                           color: _accent, size: 22),
//                     ),
//                     const SizedBox(width: 14),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text('Still need help?',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 15)),
//                           SizedBox(height: 2),
//                           Text('Our team is always here for you.',
//                               style: TextStyle(
//                                   color: Colors.white60, fontSize: 12)),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: _accent,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         elevation: 0,
//                       ),
//                       onPressed: () {},
//                       child: const Text('Chat Now',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 13)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String text) => Text(
//         text,
//         style: const TextStyle(
//           color: _textPrimary,
//           fontSize: 17,
//           fontWeight: FontWeight.w800,
//           letterSpacing: -0.3,
//         ),
//       );
// }

// // ── Channel Card ─────────────────────────────────────────────────────────────
// class _ChannelCard extends StatelessWidget {
//   final Map<String, dynamic> channel;
//   const _ChannelCard({required this.channel});

//   @override
//   Widget build(BuildContext context) {
//     final bool available = channel['available'] as bool;
//     return GestureDetector(
//       onTap: available ? () {} : null,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 3)),
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: (channel['color'] as Color).withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(channel['icon'] as IconData,
//                   color: channel['color'] as Color, size: 22),
//             ),
//             const SizedBox(height: 8),
//             Text(channel['label'] as String,
//                 style: const TextStyle(
//                     color: Color(0xFF1A1A2E),
//                     fontWeight: FontWeight.w700,
//                     fontSize: 12),
//                 textAlign: TextAlign.center),
//             const SizedBox(height: 2),
//             Text(channel['sub'] as String,
//                 style: TextStyle(
//                     color: available
//                         ? (channel['color'] as Color)
//                         : const Color(0xFF9CA3AF),
//                     fontSize: 10,
//                     fontWeight: FontWeight.w500),
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Quick Link ────────────────────────────────────────────────────────────────
// class _QuickLink {
//   final IconData icon;
//   final String label;
//   final Color color;
//   const _QuickLink(
//       {required this.icon, required this.label, required this.color});
// }

// class _QuickLinkRow extends StatelessWidget {
//   final List<_QuickLink> items;
//   const _QuickLinkRow({required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: items
//           .map((item) => GestureDetector(
//                 onTap: () {},
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 56,
//                       height: 56,
//                       decoration: BoxDecoration(
//                         color: item.color.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                             color: item.color.withOpacity(0.2), width: 1.5),
//                       ),
//                       child: Icon(item.icon, color: item.color, size: 24),
//                     ),
//                     const SizedBox(height: 7),
//                     Text(item.label,
//                         style: const TextStyle(
//                             color: Color(0xFF4B5563),
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600)),
//                   ],
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }

// // ── FAQ Tile ──────────────────────────────────────────────────────────────────
// class _FaqTile extends StatelessWidget {
//   final String question;
//   final String answer;
//   final bool isExpanded;
//   final VoidCallback onTap;

//   const _FaqTile({
//     required this.question,
//     required this.answer,
//     required this.isExpanded,
//     required this.onTap,
//   });

//   static const Color _accent = Color(0xFFE94560);
//   static const Color _primary = Color(0xFF1A1A2E);
//   static const Color _textSecondary = Color(0xFF6B7280);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isExpanded ? _accent.withOpacity(0.3) : Colors.transparent,
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: isExpanded
//                   ? _accent.withOpacity(0.08)
//                   : Colors.black.withOpacity(0.04),
//               blurRadius: isExpanded ? 16 : 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 28,
//                     height: 28,
//                     decoration: BoxDecoration(
//                       color: isExpanded
//                           ? _accent
//                           : const Color(0xFFF3F4F6),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       isExpanded
//                           ? Icons.remove_rounded
//                           : Icons.add_rounded,
//                       color: isExpanded ? Colors.white : _textSecondary,
//                       size: 16,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       question,
//                       style: TextStyle(
//                         color: _primary,
//                         fontWeight: isExpanded
//                             ? FontWeight.w700
//                             : FontWeight.w600,
//                         fontSize: 14,
//                         height: 1.3,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               AnimatedCrossFade(
//                 duration: const Duration(milliseconds: 220),
//                 crossFadeState: isExpanded
//                     ? CrossFadeState.showSecond
//                     : CrossFadeState.showFirst,
//                 firstChild: const SizedBox.shrink(),
//                 secondChild: Padding(
//                   padding: const EdgeInsets.only(top: 12, left: 40),
//                   child: Text(
//                     answer,
//                     style: const TextStyle(
//                       color: _textSecondary,
//                       fontSize: 13,
//                       height: 1.6,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }













import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int? _expandedIndex;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // // ── Brand colours ──────────────────────────────────────────────────────────
  // static const Color _primary = Color(0xFF1A1A2E);
  // static const Color _accent = Color(0xFFE94560);
  static const Color _surface = Color(0xFFF8F9FD);
  // static const Color _card = Color(0xFFFFFFFF);
  // static const Color _textPrimary = Color(0xFF1A1A2E);
  // static const Color _textSecondary = Color(0xFF6B7280);





  Future<void> _launchEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': 'Support Request',
      'body': 'Hello Brubla Team,',
    },
  );

  try {
    await launchUrl(
      emailUri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    debugPrint('Email launch error: $e');
  }
}

Future<void> _launchPhone(String phone) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phone,
  );

  try {
    await launchUrl(
      phoneUri,
      mode: LaunchMode.externalApplication, 
    );
  } catch (e) {
    debugPrint('Phone launch error: $e');
  }
}

  // ── FAQ data ────────────────────────────────────────────────────────────────
  final List<Map<String, String>> _faqs = [
    {
      'q': 'How do I track my order?',
      'a':
          'Go to My Orders in your profile tab. Tap any order to see real-time tracking.',
    },
    {
      'q': 'What is Brubla\'s return policy?',
      'a':
          'You can return most items within 30 days of delivery.',
    },
  ];

  List<Map<String, String>> get _filteredFaqs {
    if (_searchQuery.isEmpty) return _faqs;
    return _faqs
        .where((f) =>
            f['q']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            f['a']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // ── Support channel data ────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _channels = [
    {
      'icon': Icons.email_rounded,
      'label': 'Email Us',
      'sub': 'support@brubla.com',
      'color': Color(0xFF10B981),
      'available': true,
    },
    {
      'icon': Icons.phone_rounded,
      'label': 'Call Us',
      'sub': 'Mon–Sat, 9 AM–7 PM',
      'color': Color(0xFFF59E0B),
      'available': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Help Center",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          // ── Contact Channels ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: _channels.map((ch) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: ch == _channels.last ? 0 : 10,
                    ),
                    child: _ChannelCard(
                      channel: ch,
                      onTap: () {
                        if (ch['label'] == 'Email Us') {
                          _launchEmail('support@brubla.com');
                        } else if (ch['label'] == 'Call Us') {
                          _launchPhone('9961593179');
                        }
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── FAQ List ─────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              itemCount: _filteredFaqs.length,
              itemBuilder: (context, index) {
                final faq = _filteredFaqs[index];
                final isExpanded = _expandedIndex == index;

                return _FaqTile(
                  question: faq['q']!,
                  answer: faq['a']!,
                  isExpanded: isExpanded,
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Channel Card ─────────────────────────────────────────────────────────────
class _ChannelCard extends StatelessWidget {
  final Map<String, dynamic> channel;
  final VoidCallback? onTap;

  const _ChannelCard({
    required this.channel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool available = channel['available'] as bool;

    return GestureDetector(
      onTap: available ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(channel['icon'], color: channel['color'], size: 28),
            const SizedBox(height: 8),
            Text(channel['label']),
            const SizedBox(height: 4),
            Text(
              channel['sub'],
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

// ── FAQ Tile ──────────────────────────────────────────────────────────────────
class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FaqTile({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(question),
      subtitle: isExpanded ? Text(answer) : null,
      onTap: onTap,
    );
  }
}