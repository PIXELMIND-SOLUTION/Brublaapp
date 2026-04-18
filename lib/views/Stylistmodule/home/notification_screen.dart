

// import 'package:flutter/material.dart';

// class DesignerNotificationsScreen extends StatelessWidget {
//   const DesignerNotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC), // Soft designer background
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: false,
//         title: const Text(
//           "Notifications",
//           style: TextStyle(
//             color: Color(0xFF1A2C3E),
//             fontWeight: FontWeight.w700,
//             fontSize: 28,
//             letterSpacing: -0.5,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.done_all_rounded, color: Color(0xFF6366F1)),
//             onPressed: () {
//               // Mark all as read logic
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         children: [
//           // Today's section with subtle accent
//           const _SectionHeader(
//             title: "Today",
//             accentColor: Color(0xFF6366F1),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.favorite_rounded,
//             title: "New Like on 'Minimalist Logo'",
//             subtitle: "Sarah Johnson liked your design.",
//             time: "12 min ago",
//             isUnread: true,
//             iconBackground: const Color(0xFFFEE2E2),
//             iconColor: const Color(0xFFEF4444),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.comment_rounded,
//             title: "Feedback on 'Brand Identity'",
//             subtitle: "Client left comments on 3 revisions.",
//             time: "1 hour ago",
//             isUnread: true,
//             iconBackground: const Color(0xFFE0E7FF),
//             iconColor: const Color(0xFF6366F1),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.attach_money_rounded,
//             title: "Payment Received",
//             subtitle: "You received \$450 for 'Landing Page Design'.",
//             time: "3 hours ago",
//             isUnread: false,
//             iconBackground: const Color(0xFFD1FAE5),
//             iconColor: const Color(0xFF10B981),
//           ),
//           const SizedBox(height: 24),
//           const _SectionHeader(
//             title: "This Week",
//             accentColor: Color(0xFF8B5CF6),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.people_rounded,
//             title: "New Follower",
//             subtitle: "Alex Chen started following you.",
//             time: "2 days ago",
//             isUnread: false,
//             iconBackground: const Color(0xFFE0E7FF),
//             iconColor: const Color(0xFF6366F1),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.assignment_turned_in_rounded,
//             title: "Project Approved",
//             subtitle: "Client approved final mockups.",
//             time: "3 days ago",
//             isUnread: false,
//             iconBackground: const Color(0xFFD1FAE5),
//             iconColor: const Color(0xFF10B981),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.emoji_events_rounded,
//             title: "Feature: Design of the Week",
//             subtitle: "Your 'Abstract Poster' got featured.",
//             time: "5 days ago",
//             isUnread: false,
//             iconBackground: const Color(0xFFFEF3C7),
//             iconColor: const Color(0xFFF59E0B),
//           ),
//           const SizedBox(height: 24),
//           const _SectionHeader(
//             title: "Older",
//             accentColor: Color(0xFF64748B),
//           ),
//           _DesignerNotificationCard(
//             icon: Icons.tips_and_updates_rounded,
//             title: "Platform Update",
//             subtitle: "New design tools are now available.",
//             time: "1 week ago",
//             isUnread: false,
//             iconBackground: const Color(0xFFF1F5F9),
//             iconColor: const Color(0xFF475569),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom section header with accent line
// class _SectionHeader extends StatelessWidget {
//   final String title;
//   final Color accentColor;

//   const _SectionHeader({
//     required this.title,
//     required this.accentColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8, bottom: 16),
//       child: Row(
//         children: [
//           Container(
//             width: 4,
//             height: 20,
//             decoration: BoxDecoration(
//               color: accentColor,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: const Color(0xFF1E293B),
//               letterSpacing: -0.3,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Modern, designer-focused notification card
// class _DesignerNotificationCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final String time;
//   final bool isUnread;
//   final Color iconBackground;
//   final Color iconColor;

//   const _DesignerNotificationCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.time,
//     required this.isUnread,
//     required this.iconBackground,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: isUnread ? Colors.white : Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: isUnread
//             ? [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.03),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ]
//             : null,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//         child: InkWell(
//           onTap: () {},
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Icon container with soft background
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: iconBackground,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Icon(icon, color: iconColor, size: 22),
//                 ),
//                 const SizedBox(width: 16),
//                 // Content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               title,
//                               style: TextStyle(
//                                 fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
//                                 fontSize: 15,
//                                 color: const Color(0xFF0F172A),
//                                 height: 1.2,
//                               ),
//                             ),
//                           ),
//                           if (isUnread)
//                             Container(
//                               width: 8,
//                               height: 8,
//                               margin: const EdgeInsets.only(left: 8),
//                               decoration: const BoxDecoration(
//                                 color: Color(0xFF6366F1),
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         subtitle,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Color(0xFF64748B),
//                           height: 1.3,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         time,
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF94A3B8),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


















import 'package:flutter/material.dart';

class DesignerNotificationsScreen extends StatefulWidget {
  const DesignerNotificationsScreen({super.key});

  @override
  State<DesignerNotificationsScreen> createState() => _DesignerNotificationsScreenState();
}

class _DesignerNotificationsScreenState extends State<DesignerNotificationsScreen> {
  // Sample notification data
  List<Map<String, dynamic>> notifications = [
    {
      "id": "1",
      "icon": Icons.favorite_rounded,
      "title": "New Like on 'Minimalist Logo'",
      "subtitle": "Sarah Johnson liked your design.",
      "time": "12 min ago",
      "isUnread": true,
      "iconBackground": const Color(0xFFFEE2E2),
      "iconColor": const Color(0xFFEF4444),
      "section": "Today",
    },
    {
      "id": "2",
      "icon": Icons.comment_rounded,
      "title": "Feedback on 'Brand Identity'",
      "subtitle": "Client left comments on 3 revisions.",
      "time": "1 hour ago",
      "isUnread": true,
      "iconBackground": const Color(0xFFE0E7FF),
      "iconColor": const Color(0xFF6366F1),
      "section": "Today",
    },
    {
      "id": "3",
      "icon": Icons.attach_money_rounded,
      "title": "Payment Received",
      "subtitle": "You received \$450 for 'Landing Page Design'.",
      "time": "3 hours ago",
      "isUnread": false,
      "iconBackground": const Color(0xFFD1FAE5),
      "iconColor": const Color(0xFF10B981),
      "section": "Today",
    },
    {
      "id": "4",
      "icon": Icons.people_rounded,
      "title": "New Follower",
      "subtitle": "Alex Chen started following you.",
      "time": "2 days ago",
      "isUnread": false,
      "iconBackground": const Color(0xFFE0E7FF),
      "iconColor": const Color(0xFF6366F1),
      "section": "This Week",
    },
    {
      "id": "5",
      "icon": Icons.assignment_turned_in_rounded,
      "title": "Project Approved",
      "subtitle": "Client approved final mockups.",
      "time": "3 days ago",
      "isUnread": false,
      "iconBackground": const Color(0xFFD1FAE5),
      "iconColor": const Color(0xFF10B981),
      "section": "This Week",
    },
    {
      "id": "6",
      "icon": Icons.emoji_events_rounded,
      "title": "Feature: Design of the Week",
      "subtitle": "Your 'Abstract Poster' got featured.",
      "time": "5 days ago",
      "isUnread": false,
      "iconBackground": const Color(0xFFFEF3C7),
      "iconColor": const Color(0xFFF59E0B),
      "section": "This Week",
    },
    {
      "id": "7",
      "icon": Icons.tips_and_updates_rounded,
      "title": "Platform Update",
      "subtitle": "New design tools are now available.",
      "time": "1 week ago",
      "isUnread": false,
      "iconBackground": const Color(0xFFF1F5F9),
      "iconColor": const Color(0xFF475569),
      "section": "Older",
    },
  ];

  void deleteNotification(String id) {
    setState(() {
      notifications.removeWhere((notification) => notification["id"] == id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Notification deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
          },
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void deleteAllNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Delete All Notifications"),
          content: const Text("Are you sure you want to delete all notifications? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Color(0xFF64748B))),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All notifications deleted")),
                );
              },
              child: const Text("Delete All", style: TextStyle(color: Color(0xFFEF4444))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Group notifications by section
    final Map<String, List<Map<String, dynamic>>> groupedNotifications = {};
    for (var notification in notifications) {
      final section = notification["section"] as String;
      if (!groupedNotifications.containsKey(section)) {
        groupedNotifications[section] = [];
      }
      groupedNotifications[section]!.add(notification);
    }

    final sectionOrder = ["Today", "This Week", "Older"];
    final sectionColors = {
      "Today": const Color(0xFF6366F1),
      "This Week": const Color(0xFF8B5CF6),
      "Older": const Color(0xFF64748B),
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF1A2C3E),
            fontWeight: FontWeight.w700,
            fontSize: 28,
            letterSpacing: -0.5,
          ),
        ),
        
        actions: [
          if (notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444)),
              onPressed: deleteAllNotifications,
              tooltip: "Delete all",
            ),
          IconButton(
            icon: const Icon(Icons.done_all_rounded, color: Color(0xFF6366F1)),
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification["isUnread"] = false;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All marked as read")),
              );
            },
            tooltip: "Mark all as read",
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      size: 64,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No notifications",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "You're all caught up!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                for (var section in sectionOrder)
                  if (groupedNotifications.containsKey(section))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(
                          title: section,
                          accentColor: sectionColors[section]!,
                        ),
                        ...groupedNotifications[section]!.map((notification) {
                          return _DesignerNotificationCard(
                            id: notification["id"],
                            icon: notification["icon"],
                            title: notification["title"],
                            subtitle: notification["subtitle"],
                            time: notification["time"],
                            isUnread: notification["isUnread"],
                            iconBackground: notification["iconBackground"],
                            iconColor: notification["iconColor"],
                            onDelete: () => deleteNotification(notification["id"]),
                          );
                        }).toList(),
                        const SizedBox(height: 24),
                      ],
                    ),
              ],
            ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color accentColor;

  const _SectionHeader({
    required this.title,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesignerNotificationCard extends StatelessWidget {
  final String id;
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;
  final Color iconBackground;
  final Color iconColor;
  final VoidCallback onDelete;

  const _DesignerNotificationCard({
    required this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
    required this.iconBackground,
    required this.iconColor,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isUnread
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: Key(id),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          onDismissed: (direction) {
            onDelete();
          },
          child: InkWell(
            onTap: () {
              // Handle tap on notification
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container with soft background
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: iconColor, size: 22),
                  ),
                  const SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                                  fontSize: 15,
                                  color: const Color(0xFF0F172A),
                                  height: 1.2,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(left: 8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF6366F1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Delete button
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}