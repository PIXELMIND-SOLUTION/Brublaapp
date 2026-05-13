import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
import 'package:brublaapp/constant/api_constant.dart';
import 'package:brublaapp/views/profile/profile_screen.dart';
import 'package:brublaapp/views/wallet/wallet_screen.dart';
import 'package:brublaapp/views/address/address_screen.dart';
import 'package:brublaapp/views/notifications/notification_screen.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<UserProfileProvider>();
      if (provider.user == null && !provider.isFetchLoading) {
        provider.fetchProfile();
      }
    });
  }

  String? _buildImageUrl(String? rawPath) {
    if (rawPath == null || rawPath.isEmpty) return null;
    return rawPath.startsWith('http')
        ? rawPath
        : '${ApiConstants.baseUrl}/$rawPath';
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProfileProvider>();
    final profile = provider.user;
    final imageUrl = _buildImageUrl(profile?.profileImage);
    final userName = profile?.name ?? 'Guest';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              onBackgroundImageError: imageUrl != null ? (_, __) {} : null,
              child: imageUrl == null
                  ? Icon(Icons.person, size: 22, color: Colors.grey.shade400)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    size: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '1200',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressScreen()),
              );
            },
            child: _iconButton(Icons.location_on_outlined),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            child: _iconButton(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      child: Icon(icon, size: 18, color: const Color.fromARGB(221, 0, 0, 0)),
    );
  }
}
