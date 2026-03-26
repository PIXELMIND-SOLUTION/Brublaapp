import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        // leading: Container(
        //   margin: const EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Colors.grey.shade300),
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: const Icon(Icons.chevron_left, color: Colors.black),
        // ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                        child: const Icon(Icons.edit, size: 14, color: Colors.black),
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
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '9666317749',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Grid Buttons
            _buildButtonGrid(),

            // const SizedBox(height: 20),

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

            // Account List Items
            _buildAccountTile(
              icon: Icons.help_outline,
              label: 'Need Help?',
              iconColor: Colors.grey,
            ),

            const Divider(height: 1, color: Color(0xFFEEEEEE)),

            _buildAccountTile(
              icon: Icons.phone_outlined,
              label: 'Contact Us',
              iconColor: Colors.grey,
            ),

            const Divider(height: 1, color: Color(0xFFEEEEEE)),

            _buildAccountTile(
              icon: Icons.logout,
              label: 'Logout',
              iconColor: Colors.redAccent,
              labelColor: Colors.redAccent,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    final buttons = [
      _ButtonData('Orders', null, const Color(0xFFF5F5F5), Colors.black),
      _ButtonData('BMI', null, const Color(0xFFE8F0FB), Colors.black),
      _ButtonData('Help', null, const Color(0xFFF5F5F5), Colors.black),
      _ButtonData('Coupons', null, const Color(0xFFF5F5F5), Colors.black),
      _ButtonData('Address', null, const Color(0xFFFCEEEE), Colors.black),
      _ButtonData('Wishlist', null, const Color(0xFFF5F5F5), Colors.black),
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
          color: labelColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: labelColor == Colors.redAccent ? Colors.redAccent : Colors.grey,
        size: 20,
      ),
      onTap: () {},
    );
  }
}

class _ButtonData {
  final String label;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  _ButtonData(this.label, this.icon, this.bgColor, this.textColor);
}

class _ProfileButton extends StatelessWidget {
  final _ButtonData data;
  const _ProfileButton({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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