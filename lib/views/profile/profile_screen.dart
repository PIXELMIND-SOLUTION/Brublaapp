import 'package:brublaapp/views/address/address_screen.dart';
import 'package:brublaapp/views/auth/auth_screen.dart';
import 'package:brublaapp/views/contact/contact_us.dart';
import 'package:brublaapp/views/coupons/coupon_screen.dart';
import 'package:brublaapp/views/help/help_screen.dart';
import 'package:brublaapp/views/home/exclusive_screen.dart';
import 'package:brublaapp/views/myorders/my_orders.dart';
import 'package:brublaapp/views/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to logout?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.pop(context); 

              // Navigate to Auth Screen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout',style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
}
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color.fromARGB(255, 236, 236, 236),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),

      // ✅ FIXED AREA
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Profile Info Row
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: const AssetImage('assets/profile.png'),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Narasimha varma',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '9666317749',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Grid Buttons
              _buildButtonGrid(context),

              const SizedBox(height: 20),

              // Banner
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

              // Account Section
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Need Help
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

              // Contact Us
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                },
                child: _buildAccountTile(
                  icon: Icons.phone_outlined,
                  label: 'Contact Us',
                ),
              ),

              const Divider(height: 1, color: Color(0xFFEEEEEE)),

              // ✅ LOGOUT (VISIBLE NOW)
              GestureDetector(
                onTap: () {
                  _showLogoutDialog(context);
                  // print("Logout clicked"); // debug
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const AuthScreen()),
                  // );
                },
                child: _buildAccountTile(
                  icon: Icons.logout,
                  label: 'Logout',
                  iconColor: Colors.redAccent,
                  labelColor: Colors.redAccent,
                ),
              ),

              const SizedBox(height: 60), // ✅ Important fix
            ],
          ),
        ),
      ),
    );
  }

  // ================= GRID =================

  Widget _buildButtonGrid(BuildContext context) {
    final buttons = [
      _ButtonData(
        'Orders',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyOrders()),
          );
        },
      ),
      _ButtonData('BMI', null, const Color(0xFFE8F0FB), Colors.black),
      _ButtonData(
        'Help',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HelpScreen()),
          );
        },
      ),
      _ButtonData('Coupons', null, const Color(0xFFF5F5F5), Colors.black,onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponScreen()));
      },),
      _ButtonData('Address', null, const Color(0xFFFCEEEE), Colors.black,onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));
      },),
      _ButtonData(
        'Wishlist',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistScreen()),
          );
        },
      ),

      _ButtonData(
        'Subscriptions',
        null,
        const Color(0xFFF5F5F5),
        Colors.black,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExclusiveScreen()),
          );
        },
      ),
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
      itemBuilder: (context, index) {
        final btn = buttons[index];
        return _ProfileButton(data: btn);
      },
    );
  }

  // ================= LIST TILE =================

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
        style: TextStyle(
          fontSize: 14,
          // color: labelColor,
                    color: Colors.white,

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

// ================= BUTTON DATA =================

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

// ================= BUTTON UI =================

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
