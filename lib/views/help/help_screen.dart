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

//   // // ── Brand colours ──────────────────────────────────────────────────────────
//   // static const Color _primary = Color(0xFF1A1A2E);
//   // static const Color _accent = Color(0xFFE94560);
//   static const Color _surface = Color(0xFFF8F9FD);
//   // static const Color _card = Color(0xFFFFFFFF);
//   // static const Color _textPrimary = Color(0xFF1A1A2E);
//   // static const Color _textSecondary = Color(0xFF6B7280);





//   Future<void> _launchEmail(String email) async {
//   final Uri emailUri = Uri(
//     scheme: 'mailto',
//     path: email,
//     queryParameters: {
//       'subject': 'Support Request',
//       'body': 'Hello Brubla Team,',
//     },
//   );

//   try {
//     await launchUrl(
//       emailUri,
//       mode: LaunchMode.externalApplication,
//     );
//   } catch (e) {
//     debugPrint('Email launch error: $e');
//   }
// }

// Future<void> _launchPhone(String phone) async {
//   final Uri phoneUri = Uri(
//     scheme: 'tel',
//     path: phone,
//   );

//   try {
//     await launchUrl(
//       phoneUri,
//       mode: LaunchMode.externalApplication, 
//     );
//   } catch (e) {
//     debugPrint('Phone launch error: $e');
//   }
// }

//   // ── FAQ data ────────────────────────────────────────────────────────────────
//   final List<Map<String, String>> _faqs = [
//     {
//       'q': 'How do I track my order?',
//       'a':
//           'Go to My Orders in your profile tab. Tap any order to see real-time tracking.',
//     },
//     {
//       'q': 'What is Brubla\'s return policy?',
//       'a':
//           'You can return most items within 30 days of delivery.',
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
//       'available': true,
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
//       backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       body: Column(
//         children: [
//           const SizedBox(height: 50),
//           const Text(
//             "Help Center",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
//           ),

//           // ── Contact Channels ─────────────────────────────────────────────
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: _channels.map((ch) {
//                 return Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       right: ch == _channels.last ? 0 : 10,
//                     ),
//                     child: _ChannelCard(
//                       channel: ch,
//                       onTap: () {
//                         if (ch['label'] == 'Email Us') {
//                           _launchEmail('support@brubla.com');
//                         } else if (ch['label'] == 'Call Us') {
//                           _launchPhone('9961593179');
//                         }
//                       },
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),

//           // ── FAQ List ─────────────────────────────────────────────────────
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredFaqs.length,
//               itemBuilder: (context, index) {
//                 final faq = _filteredFaqs[index];
//                 final isExpanded = _expandedIndex == index;

//                 return _FaqTile(
//                   question: faq['q']!,
//                   answer: faq['a']!,
//                   isExpanded: isExpanded,
//                   onTap: () {
//                     setState(() {
//                       _expandedIndex = isExpanded ? null : index;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Channel Card ─────────────────────────────────────────────────────────────
// class _ChannelCard extends StatelessWidget {
//   final Map<String, dynamic> channel;
//   final VoidCallback? onTap;

//   const _ChannelCard({
//     required this.channel,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool available = channel['available'] as bool;

//     return GestureDetector(
//       onTap: available ? onTap : null,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           children: [
//             Icon(channel['icon'], color: channel['color'], size: 28),
//             const SizedBox(height: 8),
//             Text(channel['label']),
//             const SizedBox(height: 4),
//             Text(
//               channel['sub'],
//               style: const TextStyle(fontSize: 10),
//             ),
//           ],
//         ),
//       ),
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

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(question,),
//       subtitle: isExpanded ? Text(answer) : null,
//       onTap: onTap,
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

  static const Color _surface = Color(0xFFF8F9FD);

  // ── Launch Email ─────────────────────────────────────────────
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
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Email launch error: $e');
    }
  }

  // ── Launch Phone ─────────────────────────────────────────────
  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );

    try {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Phone launch error: $e');
    }
  }

  // ── FAQ DATA ─────────────────────────────────────────────
  final List<Map<String, String>> _faqs = [
    {
      'q': 'How do I track my order?',
      'a':
          'Go to My Orders in your profile tab. Tap any order to see real-time tracking.',
    },
    {
      'q': 'What is Brubla\'s return policy?',
      'a': 'You can return most items within 30 days of delivery.',
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

  // ── CONTACT CHANNELS ─────────────────────────────────────────────
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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Help Center",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // ── CONTACT CHANNELS ─────────────────────────────
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

          // ── FAQ LIST ─────────────────────────────
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

// ── CHANNEL CARD ─────────────────────────────────────────────
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

// ── FAQ TILE (UPDATED UI) ─────────────────────────────────────────────
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C), // Dark card
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(
            color: Color(0xFFE94560), // Accent border
            width: 3,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          question,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Colors.white,
        ),
        subtitle: isExpanded
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  answer,
                  style: const TextStyle(color: Colors.white70),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}