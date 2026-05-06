import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [
    {
      "image": "assets/notificationimage.png",
      "title": "New Shirt added",
      "time": "6 min ago",
    },
    {
      "image": "assets/notificationimage1.png",
      "title": "New Shirt added",
      "time": "6 min ago",
    },
  ];

  void deleteItem(int index) {
    setState(() {
      notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Message deleted successfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                notifications.clear();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("All messages cleared"),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  "Clear all",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: notifications.isEmpty
            ? const Center(child: Text("No notifications"))
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];

                  return Dismissible(
                    key: Key(item['title']! + index.toString()),
                    direction: DismissDirection.endToStart,

                    // Background when swiping
                    background: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),

                    onDismissed: (direction) {
                      deleteItem(index);
                    },

                    child: Column(
                      children: [
                        NotificationCard(
                          image: item["image"]!,
                          title: item["title"]!,
                          time: item["time"]!,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// ─────────────────────────────
// Notification Card Widget
// ─────────────────────────────

class NotificationCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;

  const NotificationCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}