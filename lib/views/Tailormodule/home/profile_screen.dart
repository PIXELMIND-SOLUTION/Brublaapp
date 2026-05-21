
import 'package:brublaapp/views/Tailormodule/home/edit_profile.dart';
import 'package:brublaapp/views/auth/auth_screen.dart';
import 'package:brublaapp/views/navbar/auth/auth_provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TailorProfileScreen extends StatefulWidget {
  const TailorProfileScreen({super.key});

  @override
  State<TailorProfileScreen> createState() => _TailorProfileScreenState();
}

class _TailorProfileScreenState extends State<TailorProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().fetchProfile();
    });
  }

  String? _buildImageUrl(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final base = raw.startsWith('http') ? raw : 'http://31.97.228.17:4077/$raw';
    return '$base?t=${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Logout',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    await context.read<AuthProvider>().logout();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (route) => false,
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, profileProvider, _) {
        final user = profileProvider.user;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          body: profileProvider.isFetchLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black))
              : profileProvider.fetchState == ProfileState.error
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(
                              profileProvider.errorMessage ??
                                  'Something went wrong',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: profileProvider.fetchProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Consumer<ProfileImageProvider>(
                                  builder: (context, imageProvider, _) {
                                    final imageUrl =
                                        _buildImageUrl(user?.profileImage);

                                    return Stack(
                                      children: [
                                        Container(
                                          width: 76,
                                          height: 76,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[200],
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1.5),
                                          ),
                                          child: ClipOval(
                                            child: imageProvider.isLoading
                                                ? const Center(
                                                    child: SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                : imageUrl != null
                                                    ? Image.network(
                                                        imageUrl,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (_, __, ___) =>
                                                                const Icon(
                                                          Icons.person,
                                                          size: 36,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    : const Icon(
                                                        Icons.person,
                                                        size: 36,
                                                        color: Colors.grey,
                                                      ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              final pp = context
                                                  .read<UserProfileProvider>();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const DesignerEditProfile(),
                                                ),
                                              ).then((_) {
                                                pp.fetchProfile();
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              child: const Icon(Icons.edit,
                                                  size: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user?.name ?? '—',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user?.mobile ?? '—',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600]),
                                      ),
                                      if (user?.email != null) ...[
                                        const SizedBox(height: 2),
                                        Text(
                                          user!.email,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            Divider(color: Colors.grey[200]),
                            const SizedBox(height: 16),

                            SizedBox(
                              height: 180,
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 3,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  _ActionButton(
                                    label: 'Orders',
                                    icon: Icons.receipt_long_outlined,
                                  ),
                                  _ActionButton(
                                      label: 'Help',
                                      icon: Icons.help_outline),
                                  _ActionButton(
                                    label: 'Profile',
                                    icon: Icons.person,
                                    onTap: () {
                                      final pp =
                                          context.read<UserProfileProvider>();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const DesignerEditProfile(),
                                        ),
                                      ).then((_) {
                                        pp.fetchProfile();
                                      });
                                    },
                                  ),
                                  _ActionButton(
                                    label: 'Address',
                                    icon: Icons.location_on_outlined,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Image.network(
                                    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
                                    height: 110,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 110,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.65),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 14,
                                    top: 14,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'GRAND',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        Text(
                                          '— OPENING',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          'FASHION STORE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            Text(
                              'Account',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),

                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  _AccountTile(
                                    icon: Icons.help_outline,
                                    label: 'Need Help?',
                                    onTap: () {},
                                  ),
                                  Divider(height: 1, color: Colors.grey[200]),
                                  _AccountTile(
                                    icon: Icons.phone_outlined,
                                    label: 'Contact Us',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            Consumer<AuthProvider>(
                              builder: (context, authProvider, _) {
                                final isLoggingOut = authProvider.isLoading;
                                return InkWell(
                                  onTap: isLoggingOut ? null : _logout,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      border:
                                          Border.all(color: Colors.black12),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            isLoggingOut
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : const Icon(Icons.logout,
                                                    color: Colors.red),
                                            const SizedBox(width: 12),
                                            Text(
                                              isLoggingOut
                                                  ? 'Logging out…'
                                                  : 'Logout',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.chevron_right,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionButton({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap ?? () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black, width: 1.2),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Colors.grey[700]),
                const SizedBox(width: 12),
                Text(label, style: const TextStyle(fontSize: 14)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}