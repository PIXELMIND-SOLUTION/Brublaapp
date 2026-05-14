// import 'dart:io';
// import 'package:brublaapp/views/navbar/auth/profile_image_provider.dart';
// import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// enum ProfileType { userProfile, designerProfile, tailorProfile, stylistProfile }

// extension ProfileTypeExtension on ProfileType {
//   String get label {
//     switch (this) {
//       case ProfileType.userProfile:
//         return 'User Profile';
//       case ProfileType.designerProfile:
//         return 'Designer Profile';
//       case ProfileType.tailorProfile:
//         return 'Tailor Profile';
//       case ProfileType.stylistProfile:
//         return 'Stylist Profile';
//     }
//   }

//   IconData get icon {
//     switch (this) {
//       case ProfileType.userProfile:
//         return Icons.person_outline;
//       case ProfileType.designerProfile:
//         return Icons.design_services_outlined;
//       case ProfileType.tailorProfile:
//         return Icons.content_cut_outlined;
//       case ProfileType.stylistProfile:
//         return Icons.style_outlined;
//     }
//   }

//   String get description {
//     switch (this) {
//       case ProfileType.userProfile:
//         return 'Browse and shop fashion items';
//       case ProfileType.designerProfile:
//         return 'Create and sell your designs';
//       case ProfileType.tailorProfile:
//         return 'Offer tailoring services';
//       case ProfileType.stylistProfile:
//         return 'Provide personal styling advice';
//     }
//   }

//   bool get requiresApproval {
//     return this != ProfileType.userProfile;
//   }
// }

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile>
//     with SingleTickerProviderStateMixin {
//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

//   late AnimationController _animController;
//   late Animation<double> _fadeAnim;
//   late Animation<Offset> _slideAnim;

//   ProfileType _selectedProfileType = ProfileType.userProfile;

//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _bioController = TextEditingController();

//   bool _hasUnsavedChanges = false;

//   @override
//   void initState() {
//     super.initState();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//     _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
//     _slideAnim = Tween<Offset>(
//       begin: const Offset(0, 0.06),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
//     _animController.forward();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _prefillFields();
//     });
//   }

//   String? get _remoteImageUrl {
//     final raw = context.read<UserProfileProvider>().user?.profileImage;
//     if (raw == null || raw.isEmpty) return null;
//     return raw.startsWith('http') ? raw : 'http://31.97.228.17:4077/$raw';
//   }

//   void _prefillFields() {
//     final user = context.read<UserProfileProvider>().user;
//     if (user != null) {
//       _nameController.text = user.name;
//       _emailController.text = user.email;
//       _bioController.text = user.about;
//     }
//     for (final ctrl in [_nameController, _emailController, _bioController]) {
//       ctrl.addListener(_onFieldChanged);
//     }
//   }

//   void _onFieldChanged() {
//     final user = context.read<UserProfileProvider>().user;
//     if (user == null) return;
//     final changed =
//         _nameController.text != user.name ||
//         _emailController.text != user.email ||
//         _bioController.text != user.about;
//     if (changed != _hasUnsavedChanges) {
//       setState(() => _hasUnsavedChanges = changed);
//     }
//   }

//   @override
//   void dispose() {
//     _animController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _bioController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveProfile() async {
//     final name = _nameController.text.trim();
//     final email = _emailController.text.trim();
//     final about = _bioController.text.trim();

//     if (name.isEmpty || email.isEmpty) {
//       _showSnack('Name and email cannot be empty.', isError: true);
//       return;
//     }

//     final success = await context.read<UserProfileProvider>().updateProfile(
//       name: name,
//       email: email,
//       about: about,
//     );

//     if (!mounted) return;

//     if (success) {
//       setState(() => _hasUnsavedChanges = false);
//       _showSnack('Profile updated successfully!');
//       context.read<UserProfileProvider>().resetUpdateState();
//     } else {
//       final err = context.read<UserProfileProvider>().errorMessage;
//       _showSnack(err ?? 'Failed to update profile.', isError: true);
//     }
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? picked = await _picker.pickImage(
//       source: source,
//       imageQuality: 85,
//     );
//     if (picked == null) return;

//     final file = File(picked.path);
//     setState(() => _profileImage = file);

//     final success = await context
//         .read<ProfileImageProvider>()
//         .updateProfileImage(file);

//     if (!mounted) return;

//     if (success) {
//       _showSnack('Profile photo updated!');
//     } else {
//       final err = context.read<ProfileImageProvider>().errorMessage;
//       _showSnack(
//         err.isNotEmpty ? err : 'Failed to upload image.',
//         isError: true,
//       );
//       setState(() => _profileImage = null);
//     }

//     context.read<ProfileImageProvider>().reset();
//   }

//   void _showImageSourceSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (_) => Container(
//         margin: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.black, width: 1.5),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 12),
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.black26,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 20),
//             _SheetOption(
//               icon: Icons.photo_library_outlined,
//               label: 'Choose from Gallery',
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.gallery);
//               },
//             ),
//             const Divider(height: 1, indent: 16, endIndent: 16),
//             _SheetOption(
//               icon: Icons.camera_alt_outlined,
//               label: 'Take a Photo',
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.camera);
//               },
//             ),
//             if (_profileImage != null) ...[
//               const Divider(height: 1, indent: 16, endIndent: 16),
//               _SheetOption(
//                 icon: Icons.delete_outline,
//                 label: 'Remove Photo',
//                 isDestructive: true,
//                 onTap: () {
//                   Navigator.pop(context);
//                   setState(() => _profileImage = null);
//                 },
//               ),
//             ],
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showProfileTypeSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (_) => _ProfileTypeSheet(
//         selected: _selectedProfileType,
//         onSelect: (type) {
//           Navigator.pop(context);
//           if (type != _selectedProfileType) {
//             setState(() => _selectedProfileType = type);
//             Future.delayed(const Duration(milliseconds: 200), () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ProfileAuthScreen(profileType: type),
//                 ),
//               );
//             });
//           }
//         },
//       ),
//     );
//   }

//   void _showSnack(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red[700] : Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isUpdating = context.watch<UserProfileProvider>().isUpdateLoading;
//     final isImageUploading = context.watch<ProfileImageProvider>().isLoading;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.white,
//               size: 18,
//             ),
//           ),
//         ),
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//             letterSpacing: -0.3,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: TextButton(
//               onPressed: (isUpdating || !_hasUnsavedChanges)
//                   ? null
//                   : _saveProfile,
//               style: TextButton.styleFrom(
//                 backgroundColor: _hasUnsavedChanges && !isUpdating
//                     ? Colors.black
//                     : Colors.black38,
//                 foregroundColor: Colors.white,
//                 disabledForegroundColor: Colors.white70,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//               ),
//               child: isUpdating
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     )
//                   : const Text(
//                       'Save',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnim,
//         child: SlideTransition(
//           position: _slideAnim,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 32),
//                 Center(
//                   child: Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       Container(
//                         width: 110,
//                         height: 110,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.black, width: 2.5),
//                           color: Colors.grey[100],
//                         ),

//                         child: ClipOval(
//                           child: isImageUploading
//                               ? Stack(
//                                   fit: StackFit.expand,
//                                   children: [
//                                     _buildAvatarImage(),
//                                     Container(
//                                       color: Colors.black45,
//                                       child: const Center(
//                                         child: SizedBox(
//                                           width: 28,
//                                           height: 28,
//                                           child: CircularProgressIndicator(
//                                             color: Colors.white,
//                                             strokeWidth: 2.5,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : _buildAvatarImage(),
//                         ),
//                       ),
//                       if (!isImageUploading)
//                         GestureDetector(
//                           onTap: _showImageSourceSheet,
//                           child: Container(
//                             width: 34,
//                             height: 34,
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Colors.white,
//                                 width: 2.5,
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 10),
//                 Center(
//                   child: Text(
//                     isImageUploading
//                         ? 'Uploading photo...'
//                         : 'Tap icon to change photo',
//                     style: TextStyle(
//                       color: isImageUploading
//                           ? Colors.black54
//                           : Colors.grey[500],
//                       fontSize: 12,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 const _SectionLabel(label: 'PROFILE TYPE'),
//                 const SizedBox(height: 14),
//                 _ProfileTypeSelector(
//                   selected: _selectedProfileType,
//                   onTap: _showProfileTypeSheet,
//                 ),

//                 const SizedBox(height: 32),

//                 const _SectionLabel(label: 'PERSONAL'),
//                 const SizedBox(height: 14),
//                 _ProfileField(
//                   label: 'Full Name',
//                   controller: _nameController,
//                   icon: Icons.person_outline,
//                 ),
//                 const SizedBox(height: 14),
//                 _ProfileField(
//                   label: 'Email',
//                   controller: _emailController,
//                   icon: Icons.mail_outline,
//                   keyboardType: TextInputType.emailAddress,
//                 ),

//                 const SizedBox(height: 32),

//                 const _SectionLabel(label: 'ABOUT'),
//                 const SizedBox(height: 14),
//                 _ProfileField(
//                   label: 'Bio',
//                   controller: _bioController,
//                   icon: Icons.notes_outlined,
//                   maxLines: 3,
//                 ),

//                 const SizedBox(height: 32),

//                 if (_hasUnsavedChanges)
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 20),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.amber[50],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.amber[300]!, width: 1.2),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.edit_note_outlined,
//                           size: 18,
//                           color: Colors.amber[800],
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             'You have unsaved changes. Tap Save to apply them.',
//                             style: TextStyle(
//                               fontSize: 12.5,
//                               color: Colors.amber[900],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                 const SizedBox(height: 48),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatarImage() {
//     if (_profileImage != null) {
//       return Image.file(_profileImage!, fit: BoxFit.cover);
//     }

//     final url = _remoteImageUrl;
//     if (url != null) {
//       return Image.network(
//         url,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, progress) {
//           if (progress == null) return child;
//           return Container(
//             color: Colors.grey[100],
//             child: const Center(
//               child: SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Colors.black45,
//                 ),
//               ),
//             ),
//           );
//         },
//         errorBuilder: (context, error, stack) => const _DefaultAvatar(),
//       );
//     }

//     return const _DefaultAvatar();
//   }
// }

// class _ProfileTypeSelector extends StatelessWidget {
//   final ProfileType selected;
//   final VoidCallback onTap;
//   const _ProfileTypeSelector({required this.selected, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: Colors.black12, width: 1.2),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(selected.icon, color: Colors.white, size: 18),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     selected.label,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     selected.description,
//                     style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.black54,
//               size: 22,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProfileTypeSheet extends StatelessWidget {
//   final ProfileType selected;
//   final ValueChanged<ProfileType> onSelect;
//   const _ProfileTypeSheet({required this.selected, required this.onSelect});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.black, width: 1.5),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 12),
//           Container(
//             width: 40,
//             height: 4,
//             decoration: BoxDecoration(
//               color: Colors.black26,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Select Profile Type',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 6),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'Professional profiles require admin approval before activation.',
//               style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ...ProfileType.values.map((type) {
//             final isSelected = type == selected;
//             return Column(
//               children: [
//                 if (type != ProfileType.values.first)
//                   const Divider(height: 1, indent: 16, endIndent: 16),
//                 InkWell(
//                   onTap: () => onSelect(type),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 14,
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: isSelected ? Colors.black : Colors.grey[100],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Icon(
//                             type.icon,
//                             color: isSelected ? Colors.white : Colors.black54,
//                             size: 20,
//                           ),
//                         ),
//                         const SizedBox(width: 14),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     type.label,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: isSelected
//                                           ? Colors.black
//                                           : Colors.black87,
//                                     ),
//                                   ),
//                                   if (type.requiresApproval) ...[
//                                     const SizedBox(width: 8),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 7,
//                                         vertical: 2,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.amber[50],
//                                         borderRadius: BorderRadius.circular(6),
//                                         border: Border.all(
//                                           color: Colors.amber[300]!,
//                                           width: 1,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'Approval Required',
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.amber[800],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                               const SizedBox(height: 2),
//                               Text(
//                                 type.description,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[500],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (isSelected)
//                           const Icon(
//                             Icons.check_circle,
//                             color: Colors.black,
//                             size: 20,
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// class ProfileAuthScreen extends StatefulWidget {
//   final ProfileType profileType;
//   const ProfileAuthScreen({super.key, required this.profileType});

//   @override
//   State<ProfileAuthScreen> createState() => _ProfileAuthScreenState();
// }

// class _ProfileAuthScreenState extends State<ProfileAuthScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animController;
//   late Animation<double> _fadeAnim;
//   late Animation<Offset> _slideAnim;

//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isSubmitted = false;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
//     _slideAnim = Tween<Offset>(
//       begin: const Offset(0, 0.08),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
//     _animController.forward();
//   }

//   @override
//   void dispose() {
//     _animController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitRequest() async {
//     if (_emailController.text.isEmpty ||
//         _passwordController.text.isEmpty ||
//         _nameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Please fill in all fields'),
//           backgroundColor: Colors.red[700],
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//       return;
//     }
//     setState(() => _isLoading = true);
//     await Future.delayed(const Duration(seconds: 2));
//     setState(() {
//       _isLoading = false;
//       _isSubmitted = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.white,
//               size: 18,
//             ),
//           ),
//         ),
//         title: Text(
//           widget.profileType.label,
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//             letterSpacing: -0.3,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnim,
//         child: SlideTransition(
//           position: _slideAnim,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: _isSubmitted
//                 ? _ApprovalPendingView(profileType: widget.profileType)
//                 : _AuthFormView(
//                     profileType: widget.profileType,
//                     emailController: _emailController,
//                     passwordController: _passwordController,
//                     nameController: _nameController,
//                     isPasswordVisible: _isPasswordVisible,
//                     isLoading: _isLoading,
//                     onTogglePassword: () => setState(
//                       () => _isPasswordVisible = !_isPasswordVisible,
//                     ),
//                     onSubmit: _submitRequest,
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AuthFormView extends StatelessWidget {
//   final ProfileType profileType;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final TextEditingController nameController;
//   final bool isPasswordVisible;
//   final bool isLoading;
//   final VoidCallback onTogglePassword;
//   final VoidCallback onSubmit;

//   const _AuthFormView({
//     required this.profileType,
//     required this.emailController,
//     required this.passwordController,
//     required this.nameController,
//     required this.isPasswordVisible,
//     required this.isLoading,
//     required this.onTogglePassword,
//     required this.onSubmit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 32),
//         Center(
//           child: Container(
//             width: 72,
//             height: 72,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Icon(profileType.icon, color: Colors.white, size: 34),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Center(
//           child: Text(
//             'Register as ${profileType.label}',
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//               letterSpacing: -0.5,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Center(
//           child: Text(
//             profileType.description,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//           ),
//         ),
//         const SizedBox(height: 12),
//         if (profileType.requiresApproval) ...[
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: Colors.amber[50],
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(color: Colors.amber[200]!, width: 1.2),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(Icons.info_outline, color: Colors.amber[700], size: 18),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     'This profile type requires admin approval. Once you submit your details, our team will review your application.',
//                     style: TextStyle(
//                       fontSize: 12.5,
//                       color: Colors.amber[900],
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 28),
//         ] else
//           const SizedBox(height: 28),
//         const _SectionLabel(label: 'YOUR DETAILS'),
//         const SizedBox(height: 14),
//         _AuthField(
//           controller: nameController,
//           label: 'Full Name',
//           icon: Icons.person_outline,
//           keyboardType: TextInputType.name,
//         ),
//         const SizedBox(height: 14),
//         _AuthField(
//           controller: emailController,
//           label: 'Email Address',
//           icon: Icons.mail_outline,
//           keyboardType: TextInputType.emailAddress,
//         ),
//         const SizedBox(height: 14),
//         _AuthField(
//           controller: passwordController,
//           label: 'Password',
//           icon: Icons.lock_outline,
//           obscureText: !isPasswordVisible,
//           suffixIcon: GestureDetector(
//             onTap: onTogglePassword,
//             child: Icon(
//               isPasswordVisible
//                   ? Icons.visibility_off_outlined
//                   : Icons.visibility_outlined,
//               color: Colors.black45,
//               size: 20,
//             ),
//           ),
//         ),
//         const SizedBox(height: 32),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: isLoading ? null : onSubmit,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               disabledBackgroundColor: Colors.black54,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               elevation: 0,
//             ),
//             child: isLoading
//                 ? const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : Text(
//                     profileType.requiresApproval
//                         ? 'Submit for Approval'
//                         : 'Create Account',
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//           ),
//         ),
//         const SizedBox(height: 48),
//       ],
//     );
//   }
// }

// class _ApprovalPendingView extends StatelessWidget {
//   final ProfileType profileType;
//   const _ApprovalPendingView({required this.profileType});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 60),
//         Center(
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(28),
//             ),
//             child: const Icon(
//               Icons.hourglass_top_rounded,
//               color: Colors.white,
//               size: 48,
//             ),
//           ),
//         ),
//         const SizedBox(height: 28),
//         const Text(
//           'Application Submitted!',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w800,
//             color: Colors.black,
//             letterSpacing: -0.5,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Your ${profileType.label} application has been received. Our admin team will review your details.',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.6),
//         ),
//         const SizedBox(height: 32),
//         _StatusStep(
//           number: '1',
//           title: 'Application Received',
//           subtitle: 'Your details have been submitted successfully.',
//           isDone: true,
//         ),
//         const SizedBox(height: 12),
//         _StatusStep(
//           number: '2',
//           title: 'Under Admin Review',
//           subtitle:
//               'Our team is reviewing your ${profileType.label.toLowerCase()} credentials.',
//           isPending: true,
//         ),
//         const SizedBox(height: 12),
//         _StatusStep(
//           number: '3',
//           title: 'Login Access Granted',
//           subtitle:
//               'Once approved, you can log in using your ${profileType.label} credentials.',
//         ),
//         const SizedBox(height: 36),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.black12, width: 1.2),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Icon(
//                 Icons.notifications_outlined,
//                 size: 18,
//                 color: Colors.black54,
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   'You will receive an email notification once the admin approves your account. This usually takes 1–3 business days.',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                     height: 1.5,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 32),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               elevation: 0,
//             ),
//             child: const Text(
//               'Back to Home',
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//             ),
//           ),
//         ),
//         const SizedBox(height: 60),
//       ],
//     );
//   }
// }

// class _StatusStep extends StatelessWidget {
//   final String number;
//   final String title;
//   final String subtitle;
//   final bool isDone;
//   final bool isPending;

//   const _StatusStep({
//     required this.number,
//     required this.title,
//     required this.subtitle,
//     this.isDone = false,
//     this.isPending = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final Color bgColor = isDone
//         ? Colors.black
//         : isPending
//         ? Colors.amber[100]!
//         : Colors.grey[100]!;

//     final Widget badge = isDone
//         ? const Icon(Icons.check, color: Colors.white, size: 16)
//         : Text(
//             number,
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 13,
//               color: isPending ? Colors.amber[800] : Colors.black38,
//             ),
//           );

//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: isDone
//             ? Colors.black.withOpacity(0.03)
//             : isPending
//             ? Colors.amber[50]
//             : Colors.grey[50],
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isDone
//               ? Colors.black12
//               : isPending
//               ? Colors.amber[200]!
//               : Colors.black.withOpacity(0.06),
//           width: 1.2,
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 30,
//             height: 30,
//             decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
//             child: Center(child: badge),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: isDone
//                         ? Colors.black
//                         : isPending
//                         ? Colors.amber[900]
//                         : Colors.black45,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: 12,
//                     height: 1.4,
//                     color: isDone
//                         ? Colors.black54
//                         : isPending
//                         ? Colors.amber[800]
//                         : Colors.black38,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DefaultAvatar extends StatelessWidget {
//   const _DefaultAvatar();
//   @override
//   Widget build(BuildContext context) => Container(
//     color: Colors.grey[100],
//     child: Icon(Icons.person, size: 54, color: Colors.grey[400]),
//   );
// }

// class _SectionLabel extends StatelessWidget {
//   final String label;
//   const _SectionLabel({required this.label});
//   @override
//   Widget build(BuildContext context) => Text(
//     label,
//     style: const TextStyle(
//       fontSize: 11,
//       fontWeight: FontWeight.w700,
//       letterSpacing: 1.8,
//       color: Colors.black45,
//     ),
//   );
// }

// class _ProfileField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final IconData icon;
//   final int maxLines;
//   final TextInputType keyboardType;

//   const _ProfileField({
//     required this.label,
//     required this.controller,
//     required this.icon,
//     this.maxLines = 1,
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.black12, width: 1.2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(
//             color: Colors.black38,
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//           ),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.only(left: 14, right: 8),
//             child: Icon(icon, color: Colors.black54, size: 20),
//           ),
//           prefixIconConstraints: const BoxConstraints(
//             minWidth: 0,
//             minHeight: 0,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 14,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//         ),
//         cursorColor: Colors.black,
//       ),
//     );
//   }
// }

// class _AuthField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final IconData icon;
//   final TextInputType keyboardType;
//   final bool obscureText;
//   final Widget? suffixIcon;

//   const _AuthField({
//     required this.controller,
//     required this.label,
//     required this.icon,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.suffixIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.black12, width: 1.2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//           color: Colors.black87,
//         ),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(
//             color: Colors.black38,
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//           ),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.only(left: 14, right: 8),
//             child: Icon(icon, color: Colors.black54, size: 20),
//           ),
//           prefixIconConstraints: const BoxConstraints(
//             minWidth: 0,
//             minHeight: 0,
//           ),
//           suffixIcon: suffixIcon != null
//               ? Padding(
//                   padding: const EdgeInsets.only(right: 14),
//                   child: suffixIcon,
//                 )
//               : null,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 14,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//         ),
//         cursorColor: Colors.black,
//       ),
//     );
//   }
// }

// class _SheetOption extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final bool isDestructive;

//   const _SheetOption({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.isDestructive = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = isDestructive ? Colors.red[700]! : Colors.black87;
//     return ListTile(
//       leading: Icon(icon, color: color, size: 22),
//       title: Text(
//         label,
//         style: TextStyle(
//           fontWeight: FontWeight.w500,
//           fontSize: 15,
//           color: color,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }








///////////////////////////// This one is the previous code used for edit profile//////////////







//////////////////////////////// Refractor code for edit profile sceeen ///////////////////////////



// ignore_for_file: dangling_library_doc_comments

import 'dart:io';
import 'package:brublaapp/views/navbar/auth/profile_image_provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
import 'package:brublaapp/widgets/profile/default_avatar_widget.dart';
import 'package:brublaapp/widgets/profile/profile_auth_widget.dart';
import 'package:brublaapp/widgets/profile/profile_field_widget.dart';
import 'package:brublaapp/widgets/profile/profile_selector_widget.dart';
import 'package:brublaapp/widgets/profile/profile_sheet_widget.dart';
import 'package:brublaapp/widgets/profile/profile_type_widget.dart';
import 'package:brublaapp/widgets/profile/section_label_widget.dart';
import 'package:brublaapp/widgets/profile/sheet_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  ProfileType _selectedProfileType = ProfileType.userProfile;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefillFields();
    });
  }

  String? get _remoteImageUrl {
    final raw = context.read<UserProfileProvider>().user?.profileImage;
    if (raw == null || raw.isEmpty) return null;
    return raw.startsWith('http') ? raw : 'http://31.97.228.17:4077/$raw';
  }

  void _prefillFields() {
    final user = context.read<UserProfileProvider>().user;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _bioController.text = user.about;
    }
    for (final ctrl in [_nameController, _emailController, _bioController]) {
      ctrl.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    final user = context.read<UserProfileProvider>().user;
    if (user == null) return;
    final changed =
        _nameController.text != user.name ||
        _emailController.text != user.email ||
        _bioController.text != user.about;
    if (changed != _hasUnsavedChanges) {
      setState(() => _hasUnsavedChanges = changed);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final about = _bioController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      _showSnack('Name and email cannot be empty.', isError: true);
      return;
    }

    final success = await context.read<UserProfileProvider>().updateProfile(
      name: name,
      email: email,
      about: about,
    );

    if (!mounted) return;

    if (success) {
      setState(() => _hasUnsavedChanges = false);
      _showSnack('Profile updated successfully!');
      context.read<UserProfileProvider>().resetUpdateState();
    } else {
      final err = context.read<UserProfileProvider>().errorMessage;
      _showSnack(err ?? 'Failed to update profile.', isError: true);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null) return;

    final file = File(picked.path);
    setState(() => _profileImage = file);

    final success = await context
        .read<ProfileImageProvider>()
        .updateProfileImage(file);

    if (!mounted) return;

    if (success) {
      _showSnack('Profile photo updated!');
    } else {
      final err = context.read<ProfileImageProvider>().errorMessage;
      _showSnack(
        err.isNotEmpty ? err : 'Failed to upload image.',
        isError: true,
      );
      setState(() => _profileImage = null);
    }

    context.read<ProfileImageProvider>().reset();
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            SheetOption(
              icon: Icons.photo_library_outlined,
              label: 'Choose from Gallery',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            SheetOption(
              icon: Icons.camera_alt_outlined,
              label: 'Take a Photo',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            if (_profileImage != null) ...[
              const Divider(height: 1, indent: 16, endIndent: 16),
              SheetOption(
                icon: Icons.delete_outline,
                label: 'Remove Photo',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _profileImage = null);
                },
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showProfileTypeSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ProfileTypeSheet(
        selected: _selectedProfileType,
        onSelect: (type) {
          Navigator.pop(context);
          if (type != _selectedProfileType) {
            setState(() => _selectedProfileType = type);
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileAuthScreen(profileType: type),
                ),
              );
            });
          }
        },
      ),
    );
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[700] : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = context.watch<UserProfileProvider>().isUpdateLoading;
    final isImageUploading = context.watch<ProfileImageProvider>().isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: (isUpdating || !_hasUnsavedChanges)
                  ? null
                  : _saveProfile,
              style: TextButton.styleFrom(
                backgroundColor: _hasUnsavedChanges && !isUpdating
                    ? Colors.black
                    : Colors.black38,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: isUpdating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.5),
                          color: Colors.grey[100],
                        ),
                        child: ClipOval(
                          child: isImageUploading
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    _buildAvatarImage(),
                                    Container(
                                      color: Colors.black45,
                                      child: const Center(
                                        child: SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : _buildAvatarImage(),
                        ),
                      ),
                      if (!isImageUploading)
                        GestureDetector(
                          onTap: _showImageSourceSheet,
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    isImageUploading
                        ? 'Uploading photo...'
                        : 'Tap icon to change photo',
                    style: TextStyle(
                      color: isImageUploading
                          ? Colors.black54
                          : Colors.grey[500],
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const SectionLabel(label: 'PROFILE TYPE'),
                const SizedBox(height: 14),
                ProfileTypeSelector(
                  selected: _selectedProfileType,
                  onTap: _showProfileTypeSheet,
                ),
                const SizedBox(height: 32),
                const SectionLabel(label: 'PERSONAL'),
                const SizedBox(height: 14),
                ProfileField(
                  label: 'Full Name',
                  controller: _nameController,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                ProfileField(
                  label: 'Email',
                  controller: _emailController,
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 32),
                const SectionLabel(label: 'ABOUT'),
                const SizedBox(height: 14),
                ProfileField(
                  label: 'Bio',
                  controller: _bioController,
                  icon: Icons.notes_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                if (_hasUnsavedChanges)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber[300]!, width: 1.2),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_note_outlined,
                          size: 18,
                          color: Colors.amber[800],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'You have unsaved changes. Tap Save to apply them.',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.amber[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarImage() {
    if (_profileImage != null) {
      return Image.file(_profileImage!, fit: BoxFit.cover);
    }

    final url = _remoteImageUrl;
    if (url != null) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey[100],
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black45,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stack) => const DefaultAvatar(),
      );
    }

    return const DefaultAvatar();
  }
}
