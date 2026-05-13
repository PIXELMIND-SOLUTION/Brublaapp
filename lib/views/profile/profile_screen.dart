// ignore_for_file: deprecated_member_use

import 'package:brublaapp/views/address/address_screen.dart';
import 'package:brublaapp/views/auth/auth_screen.dart';
import 'package:brublaapp/views/contact/contact_us.dart';
import 'package:brublaapp/views/coupons/coupon_screen.dart';
import 'package:brublaapp/views/help/help_screen.dart';
import 'package:brublaapp/views/home/exclusive_screen.dart';
import 'package:brublaapp/views/myorders/my_orders.dart';
import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
import 'package:brublaapp/views/profile/edit_profile.dart';
import 'package:brublaapp/views/wishlist/wishlist_screen.dart';
import 'package:brublaapp/views/navbar/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().fetchProfile();
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);

                context.read<UserProfileProvider>().clearUser();
                await context.read<AuthProvider>().logout();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String? _buildImageUrl(String? rawPath) {
    if (rawPath == null || rawPath.isEmpty) return null;
    return rawPath.startsWith('http')
        ? rawPath
        : 'http://31.97.228.17:4077/$rawPath';
  }

  Widget _buildProfileAvatar(String? rawPath) {
    final url = _buildImageUrl(rawPath);
    return CircleAvatar(
      radius: 36,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: url != null ? NetworkImage(url) : null,
      onBackgroundImageError: url != null ? (_, __) {} : null,
      child: url == null
          ? Icon(Icons.person, size: 36, color: Colors.grey.shade400)
          : null,
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<AuthProvider>().currentUser;
    final profileProv = context.watch<UserProfileProvider>();
    final profile = profileProv.user;

    // Profile API data takes priority; fall back to AuthProvider cache
    final userName = profile?.name ?? authUser?.name ?? 'Guest';
    final userMobile = profile?.mobile ?? authUser?.mobile ?? '';
    final userEmail = profile?.email ?? authUser?.email ?? '';

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await _showExitDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            if (profileProv.fetchState == ProfileState.error)
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.black),
                tooltip: 'Retry',
                onPressed: () => profileProv.fetchProfile(),
              ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ),
                            );
                          },
                          child: _buildProfileAvatar(profile?.profileImage),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 46,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: _ProfileHeaderInfo(
                        userName: userName,
                        userMobile: userMobile,
                        userEmail: userEmail,
                        isLoading: profileProv.isFetchLoading,
                        hasError: profileProv.fetchState == ProfileState.error,
                        errorMsg: profileProv.errorMessage,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                _buildButtonGrid(context),

                const SizedBox(height: 20),

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/banner.png',
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HelpScreen()),
                    );
                  },
                  child: _buildAccountTile(
                    icon: Icons.help_outline,
                    label: 'Need Help?',
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFEEEEEE)),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  },
                  child: _buildAccountTile(
                    icon: Icons.phone_outlined,
                    label: 'Contact Us',
                  ),
                ),

                const Divider(height: 1, color: Color(0xFFEEEEEE)),

                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: _buildAccountTile(
                    icon: Icons.logout,
                    label: 'Logout',
                    iconColor: Colors.redAccent,
                    labelColor: Colors.redAccent,
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonGrid(BuildContext context) {
    final buttons = [
      _ButtonData(
        'Orders',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyOrders()),
        ),
      ),
      _ButtonData('BMI', null, const Color(0xFFE8F0FB), Colors.black),
      _ButtonData(
        'Help',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HelpScreen()),
        ),
      ),
      _ButtonData(
        'Coupons',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CouponScreen()),
        ),
      ),
      _ButtonData(
        'Address',
        null,
        const Color(0xFFFCEEEE),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddressScreen()),
        ),
      ),
      _ButtonData(
        'Wishlist',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishlistScreen()),
        ),
      ),
      _ButtonData(
        'Subscriptions',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExclusiveScreen()),
        ),
      ),
      _ButtonData(
        'Profile',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfile()),
        ),
      ),

      //  _ButtonData(
      //   'Settings',
      //   null,
      //   const Color(0xFFF5F5F5),
      //   Colors.black,
      //   onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SettingsScreen()),
      //   ),
      // ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.2,
      ),
      itemBuilder: (context, index) => _ProfileButton(data: buttons[index]),
    );
  }

  Widget _buildAccountTile({
    required IconData icon,
    required String label,
    Color iconColor = Colors.grey,
    Color labelColor = Colors.black,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: labelColor == Colors.redAccent ? Colors.redAccent : Colors.grey,
        size: 20,
      ),
    );
  }
}

class _ProfileHeaderInfo extends StatelessWidget {
  final String userName;
  final String userMobile;
  final String userEmail;
  final bool isLoading;
  final bool hasError;
  final String? errorMsg;

  const _ProfileHeaderInfo({
    required this.userName,
    required this.userMobile,
    required this.userEmail,
    required this.isLoading,
    required this.hasError,
    this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && userName == 'Guest') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBox(width: 120, height: 14),
          const SizedBox(height: 6),
          _ShimmerBox(width: 90, height: 12),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isLoading) ...[
              const SizedBox(width: 8),
              const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.black54,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          userMobile,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        if (hasError && userName == 'Guest') ...[
          const SizedBox(height: 4),
          Text(
            errorMsg ?? 'Could not load profile',
            style: const TextStyle(fontSize: 11, color: Colors.redAccent),
          ),
        ],
      ],
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  const _ShimmerBox({required this.width, required this.height});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.7).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(_anim.value),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _ButtonData {
  final String label;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onTap;

  _ButtonData(
    this.label,
    this.icon,
    this.bgColor,
    this.textColor, {
    this.onTap,
  });
}

class _ProfileButton extends StatelessWidget {
  final _ButtonData data;
  const _ProfileButton({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: data.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          data.label,
          style: TextStyle(
            color: data.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
