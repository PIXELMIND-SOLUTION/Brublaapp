// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';

// // // class DesignerEditProfile extends StatefulWidget {
// // //   const DesignerEditProfile({super.key});

// // //   @override
// // //   State<DesignerEditProfile> createState() => _EditProfileState();
// // // }

// // // class _EditProfileState extends State<DesignerEditProfile> {
// // //   File? _pickedImage;
// // //   final ImagePicker _picker = ImagePicker();

// // //   final _formKey = GlobalKey<FormState>();

// // //   final _nameController = TextEditingController(text: 'Narasimha Varma');
// // //   final _phoneController = TextEditingController(text: '9666317749');
// // //   final _emailController = TextEditingController(text: 'narasimha@email.com');
// // //   final _shopNameController = TextEditingController(text: 'Varma Tailors');
// // //   final _addressController = TextEditingController(text: '12, Main Street, Hyderabad');
// // //   final _specialityController = TextEditingController(text: 'Bridal & Formal Wear');

// // //   Future<void> _pickImage() async {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       backgroundColor: Colors.white,
// // //       shape: const RoundedRectangleBorder(
// // //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// // //       ),
// // //       builder: (context) => SafeArea(
// // //         child: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             Container(
// // //               width: 40,
// // //               height: 4,
// // //               margin: const EdgeInsets.symmetric(vertical: 12),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.grey[300],
// // //                 borderRadius: BorderRadius.circular(4),
// // //               ),
// // //             ),
// // //             const Padding(
// // //               padding: EdgeInsets.only(bottom: 8),
// // //               child: Text(
// // //                 'Choose Photo',
// // //                 style: TextStyle(
// // //                   fontFamily: 'Georgia',
// // //                   fontWeight: FontWeight.w700,
// // //                   fontSize: 16,
// // //                 ),
// // //               ),
// // //             ),
// // //             const Divider(),
// // //             ListTile(
// // //               leading: const Icon(Icons.photo_library_outlined, color: Colors.black),
// // //               title: const Text('Choose from Gallery',
// // //                   style: TextStyle(fontWeight: FontWeight.w500)),
// // //               onTap: () async {
// // //                 Navigator.pop(context);
// // //                 final XFile? image =
// // //                     await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
// // //                 if (image != null) {
// // //                   setState(() => _pickedImage = File(image.path));
// // //                 }
// // //               },
// // //             ),
// // //             ListTile(
// // //               leading: const Icon(Icons.camera_alt_outlined, color: Colors.black),
// // //               title: const Text('Take a Photo',
// // //                   style: TextStyle(fontWeight: FontWeight.w500)),
// // //               onTap: () async {
// // //                 Navigator.pop(context);
// // //                 final XFile? image =
// // //                     await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
// // //                 if (image != null) {
// // //                   setState(() => _pickedImage = File(image.path));
// // //                 }
// // //               },
// // //             ),
// // //             const SizedBox(height: 8),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _nameController.dispose();
// // //     _phoneController.dispose();
// // //     _emailController.dispose();
// // //     _shopNameController.dispose();
// // //     _addressController.dispose();
// // //     _specialityController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.black),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //         title: const Text(
// // //           'Edit Profile',
// // //           style: TextStyle(
// // //             fontFamily: 'Georgia',
// // //             color: Colors.black,
// // //             fontWeight: FontWeight.w700,
// // //             fontSize: 18,
// // //             letterSpacing: 0.4,
// // //           ),
// // //         ),
// // //         centerTitle: true,
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () {
// // //               if (_formKey.currentState!.validate()) {
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   const SnackBar(
// // //                     content: Text('Profile saved successfully'),
// // //                     backgroundColor: Colors.black,
// // //                   ),
// // //                 );
// // //               }
// // //             },
// // //             child: const Text(
// // //               'Save',
// // //               style: TextStyle(
// // //                 color: Colors.black,
// // //                 fontWeight: FontWeight.w700,
// // //                 fontSize: 14,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               /// ── Header Banner with Avatar ──
// // //               Container(
// // //                 width: double.infinity,
// // //                 color: Colors.black,
// // //                 padding: const EdgeInsets.symmetric(vertical: 32),
// // //                 child: Column(
// // //                   children: [
// // //                     GestureDetector(
// // //                       onTap: _pickImage,
// // //                       child: Stack(
// // //                         children: [
// // //                           Container(
// // //                             width: 90,
// // //                             height: 90,
// // //                             decoration: BoxDecoration(
// // //                               shape: BoxShape.circle,
// // //                               border: Border.all(color: Colors.white, width: 2.5),
// // //                               color: Colors.grey[800],
// // //                             ),
// // //                             child: ClipOval(
// // //                               child: _pickedImage != null
// // //                                   ? Image.file(_pickedImage!, fit: BoxFit.cover)
// // //                                   : Image.network(
// // //                                       'https://randomuser.me/api/portraits/men/75.jpg',
// // //                                       fit: BoxFit.cover,
// // //                                       errorBuilder: (_, __, ___) => const Icon(
// // //                                         Icons.person,
// // //                                         size: 40,
// // //                                         color: Colors.white54,
// // //                                       ),
// // //                                     ),
// // //                             ),
// // //                           ),
// // //                           Positioned(
// // //                             bottom: 0,
// // //                             right: 0,
// // //                             child: Container(
// // //                               padding: const EdgeInsets.all(5),
// // //                               decoration: const BoxDecoration(
// // //                                 color: Colors.white,
// // //                                 shape: BoxShape.circle,
// // //                               ),
// // //                               child: const Icon(Icons.camera_alt,
// // //                                   size: 14, color: Colors.black),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 12),
// // //                     const Text(
// // //                       'Tap to change photo',
// // //                       style: TextStyle(
// // //                         color: Colors.white60,
// // //                         fontSize: 12,
// // //                         letterSpacing: 0.5,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 28),

// // //               /// ── Personal Info Section ──
// // //               _SectionHeader(title: 'Personal Info'),
// // //               const SizedBox(height: 12),
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                 child: Column(
// // //                   children: [
// // //                     _StyledField(
// // //                       label: 'Full Name',
// // //                       controller: _nameController,
// // //                       icon: Icons.person_outline,
// // //                       validator: (v) =>
// // //                           v == null || v.isEmpty ? 'Name is required' : null,
// // //                     ),
// // //                     const SizedBox(height: 14),
// // //                     _StyledField(
// // //                       label: 'Phone Number',
// // //                       controller: _phoneController,
// // //                       icon: Icons.phone_outlined,
// // //                       keyboardType: TextInputType.phone,
// // //                       validator: (v) =>
// // //                           v == null || v.length < 10 ? 'Enter valid phone' : null,
// // //                     ),
// // //                     const SizedBox(height: 14),
// // //                     _StyledField(
// // //                       label: 'Email Address',
// // //                       controller: _emailController,
// // //                       icon: Icons.mail_outline,
// // //                       keyboardType: TextInputType.emailAddress,
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 28),

// // //               /// ── Shop Info Section ──
// // //               _SectionHeader(title: 'Shop Details'),
// // //               const SizedBox(height: 12),
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                 child: Column(
// // //                   children: [
// // //                     _StyledField(
// // //                       label: 'Shop Name',
// // //                       controller: _shopNameController,
// // //                       icon: Icons.store_outlined,
// // //                     ),
// // //                     const SizedBox(height: 14),
// // //                     _StyledField(
// // //                       label: 'Speciality',
// // //                       controller: _specialityController,
// // //                       icon: Icons.star_outline,
// // //                       hint: 'e.g. Bridal, Casual, Formal',
// // //                     ),
// // //                     const SizedBox(height: 14),
// // //                     _StyledField(
// // //                       label: 'Address',
// // //                       controller: _addressController,
// // //                       icon: Icons.location_on_outlined,
// // //                       maxLines: 2,
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 32),

// // //               /// ── Save Button ──
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                 child: SizedBox(
// // //                   width: double.infinity,
// // //                   height: 52,
// // //                   child: ElevatedButton(
// // //                     onPressed: () {
// // //                       if (_formKey.currentState!.validate()) {
// // //                         ScaffoldMessenger.of(context).showSnackBar(
// // //                           const SnackBar(
// // //                             content: Text('Profile saved successfully'),
// // //                             backgroundColor: Colors.black,
// // //                           ),
// // //                         );
// // //                       }
// // //                     },
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.black,
// // //                       foregroundColor: Colors.white,
// // //                       elevation: 0,
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(10),
// // //                       ),
// // //                     ),
// // //                     child: const Text(
// // //                       'SAVE CHANGES',
// // //                       style: TextStyle(
// // //                         letterSpacing: 1.5,
// // //                         fontWeight: FontWeight.w700,
// // //                         fontSize: 14,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 40),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // /// ── Section Header ──
// // // class _SectionHeader extends StatelessWidget {
// // //   final String title;
// // //   const _SectionHeader({required this.title});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // //       child: Row(
// // //         children: [
// // //           Container(width: 3, height: 16, color: Colors.black),
// // //           const SizedBox(width: 8),
// // //           Text(
// // //             title.toUpperCase(),
// // //             style: const TextStyle(
// // //               fontSize: 11,
// // //               fontWeight: FontWeight.w700,
// // //               letterSpacing: 2,
// // //               color: Colors.black,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // /// ── Styled Text Field ──
// // // class _StyledField extends StatelessWidget {
// // //   final String label;
// // //   final TextEditingController controller;
// // //   final IconData icon;
// // //   final TextInputType? keyboardType;
// // //   final String? Function(String?)? validator;
// // //   final int maxLines;
// // //   final String? hint;

// // //   const _StyledField({
// // //     required this.label,
// // //     required this.controller,
// // //     required this.icon,
// // //     this.keyboardType,
// // //     this.validator,
// // //     this.maxLines = 1,
// // //     this.hint,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return TextFormField(
// // //       controller: controller,
// // //       keyboardType: keyboardType,
// // //       validator: validator,
// // //       maxLines: maxLines,
// // //       style: const TextStyle(
// // //         fontSize: 14,
// // //         fontWeight: FontWeight.w500,
// // //         color: Colors.black,
// // //       ),
// // //       decoration: InputDecoration(
// // //         labelText: label,
// // //         hintText: hint,
// // //         hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
// // //         labelStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
// // //         prefixIcon: Icon(icon, size: 18, color: Colors.grey[600]),
// // //         filled: true,
// // //         fillColor: Colors.grey[50],
// // //         contentPadding:
// // //             const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
// // //         enabledBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(10),
// // //           borderSide: BorderSide(color: Colors.grey.shade200),
// // //         ),
// // //         focusedBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(10),
// // //           borderSide: const BorderSide(color: Colors.black, width: 1.5),
// // //         ),
// // //         errorBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(10),
// // //           borderSide: const BorderSide(color: Colors.red),
// // //         ),
// // //         focusedErrorBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(10),
// // //           borderSide: const BorderSide(color: Colors.red, width: 1.5),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }






































// import 'dart:io';
// import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
// import 'package:brublaapp/views/navbar/auth/profile_image_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class DesignerEditProfile extends StatefulWidget {
//   const DesignerEditProfile({super.key});

//   @override
//   State<DesignerEditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<DesignerEditProfile> {
//   File? _pickedImage;
//   final ImagePicker _picker = ImagePicker();

//   final _formKey = GlobalKey<FormState>();

//   final _nameController   = TextEditingController();
//   final _emailController  = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _aboutController  = TextEditingController();

//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<UserProfileProvider>().fetchProfile();
//     });
//   }



//   String? get _remoteImageUrl {
//   final raw = context.read<UserProfileProvider>().user?.profileImage;
//   if (raw == null || raw.isEmpty) return null;
//   final base = raw.startsWith('http') ? raw : 'http://31.97.228.17:4077/$raw';
//   return '$base?t=${DateTime.now().millisecondsSinceEpoch}';
// }

//   void _populateFields(UserProfileProvider provider) {
//     if (_isInitialized) return;
//     final user = provider.user;
//     if (user == null) return;

//     _nameController.text   = user.name;
//     _emailController.text  = user.email;
//     _mobileController.text = user.mobile ?? '';
//     _aboutController.text  = user.about  ?? '';

//     _isInitialized = true;
//   }

//   Future<void> _pickImage() async {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               margin: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 8),
//               child: Text(
//                 'Choose Photo',
//                 style: TextStyle(
//                   fontFamily: 'Georgia',
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.photo_library_outlined, color: Colors.black),
//               title: const Text('Choose from Gallery',
//                   style: TextStyle(fontWeight: FontWeight.w500)),
//               onTap: () async {
//                 Navigator.pop(ctx);
//                 final XFile? image = await _picker.pickImage(
//                     source: ImageSource.gallery, imageQuality: 80);
//                 if (image != null) {
//                   await _handlePickedImage(File(image.path));
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera_alt_outlined, color: Colors.black),
//               title: const Text('Take a Photo',
//                   style: TextStyle(fontWeight: FontWeight.w500)),
//               onTap: () async {
//                 Navigator.pop(ctx);
//                 final XFile? image = await _picker.pickImage(
//                     source: ImageSource.camera, imageQuality: 80);
//                 if (image != null) {
//                   await _handlePickedImage(File(image.path));
//                 }
//               },
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Sets the local preview, then uploads via [ProfileImageProvider].
//   Future<void> _handlePickedImage(File imageFile) async {
//     setState(() => _pickedImage = imageFile);

//     final imageProvider = context.read<ProfileImageProvider>();
//     imageProvider.reset();

//     final success = await imageProvider.updateProfileImage(imageFile);

//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           success
//               ? (imageProvider.successMessage)
//               : (imageProvider.errorMessage),
//         ),
//         backgroundColor: success ? Colors.black : Colors.red,
//       ),
//     );

//     // If upload succeeded, refresh the profile so the new URL is reflected.
//     if (success) {
//       context.read<UserProfileProvider>().fetchProfile();
//     } else {
//       // Revert local preview on failure.
//       setState(() => _pickedImage = null);
//     }
//   }

//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;

//     final provider = context.read<UserProfileProvider>();

//     final success = await provider.updateProfile(
//       name:  _nameController.text.trim(),
//       email: _emailController.text.trim(),
//       about: _aboutController.text.trim(),
//     );

//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           success
//               ? 'Profile saved successfully'
//               : (provider.errorMessage ?? 'Failed to save profile'),
//         ),
//         backgroundColor: success ? Colors.black : Colors.red,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _mobileController.dispose();
//     _aboutController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProfileProvider>(
//       builder: (context, provider, _) {
//         if (provider.fetchState == ProfileState.success) {
//           _populateFields(provider);
//         }

//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () => Navigator.pop(context),
//             ),
//             title: const Text(
//               'Edit Profile',
//               style: TextStyle(
//                 fontFamily: 'Georgia',
//                 color: Colors.black,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//                 letterSpacing: 0.4,
//               ),
//             ),
//             centerTitle: true,
//             actions: [
//               provider.isUpdateLoading
//                   ? const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Center(
//                         child: SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(
//                               strokeWidth: 2, color: Colors.black),
//                         ),
//                       ),
//                     )
//                   : TextButton(
//                       onPressed: _saveProfile,
//                       child: const Text(
//                         'Save',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//             ],
//           ),
//           body: provider.isFetchLoading
//               ? const Center(
//                   child: CircularProgressIndicator(color: Colors.black))
//               : provider.fetchState == ProfileState.error
//                   ? _ErrorView(
//                       message: provider.errorMessage ?? 'Something went wrong',
//                       onRetry: provider.fetchProfile,
//                     )
//                   : _buildForm(provider),
//         );
//       },
//     );
//   }

//   Widget _buildForm(UserProfileProvider provider) {
//     final user = provider.user;

//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// ── Header Banner with Avatar ──
//             Consumer<ProfileImageProvider>(
//               builder: (context, imageProvider, _) {
//                 return Container(
//                   width: double.infinity,
//                   color: Colors.black,
//                   padding: const EdgeInsets.symmetric(vertical: 32),
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         // Disable tap while image is uploading.
//                         onTap: imageProvider.isLoading ? null : _pickImage,
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: 90,
//                               height: 90,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     color: Colors.white, width: 2.5),
//                                 color: Colors.grey[800],
//                               ),
//                               child: ClipOval(
//                                 child: _pickedImage != null
//                                     ? Image.file(_pickedImage!,
//                                         fit: BoxFit.cover)
//                                     : (user?.profileImage != null
//                                         ? Image.network(
//                                             user!.profileImage!,
//                                             fit: BoxFit.cover,
//                                             errorBuilder: (_, __, ___) =>
//                                                 const Icon(Icons.person,
//                                                     size: 40,
//                                                     color: Colors.white54),
//                                           )
//                                         : const Icon(Icons.person,
//                                             size: 40,
//                                             color: Colors.white54)),
//                               ),
//                             ),

//                             // Upload progress overlay
//                             if (imageProvider.isLoading)
//                               Positioned.fill(
//                                 child: Container(
//                                   decoration: const BoxDecoration(
//                                     color: Colors.black45,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Center(
//                                     child: SizedBox(
//                                       width: 24,
//                                       height: 24,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                             // Camera icon badge (hidden while uploading)
//                             if (!imageProvider.isLoading)
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(5),
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(Icons.camera_alt,
//                                       size: 14, color: Colors.black),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         imageProvider.isLoading
//                             ? 'Uploading…'
//                             : 'Tap to change photo',
//                         style: const TextStyle(
//                             color: Colors.white60,
//                             fontSize: 12,
//                             letterSpacing: 0.5),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),

//             const SizedBox(height: 28),

//             /// ── Personal Info Section ──
//             const _SectionHeader(title: 'Personal Info'),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   _StyledField(
//                     label: 'Full Name',
//                     controller: _nameController,
//                     icon: Icons.person_outline,
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Name is required' : null,
//                   ),
//                   const SizedBox(height: 14),
//                   _StyledField(
//                     label: 'Mobile Number',
//                     controller: _mobileController,
//                     icon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                     readOnly: true,
//                   ),
//                   const SizedBox(height: 14),
//                   _StyledField(
//                     label: 'Email Address',
//                     controller: _emailController,
//                     icon: Icons.mail_outline,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (v) =>
//                         v == null || v.isEmpty ? 'Email is required' : null,
//                   ),
//                   const SizedBox(height: 14),
//                   _StyledField(
//                     label: 'About',
//                     controller: _aboutController,
//                     icon: Icons.info_outline,
//                     hint: 'Tell clients about yourself…',
//                     maxLines: 3,
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 32),

//             /// ── Save Button ──
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   onPressed: provider.isUpdateLoading ? null : _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     foregroundColor: Colors.white,
//                     disabledBackgroundColor: Colors.grey[400],
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: provider.isUpdateLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                               strokeWidth: 2, color: Colors.white),
//                         )
//                       : const Text(
//                           'SAVE CHANGES',
//                           style: TextStyle(
//                             letterSpacing: 1.5,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 14,
//                           ),
//                         ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Error View ──
// class _ErrorView extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//   const _ErrorView({required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, size: 48, color: Colors.red),
//             const SizedBox(height: 16),
//             Text(message,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 14, color: Colors.black54)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: onRetry,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Section Header ──
// class _SectionHeader extends StatelessWidget {
//   final String title;
//   const _SectionHeader({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           Container(width: 3, height: 16, color: Colors.black),
//           const SizedBox(width: 8),
//           Text(
//             title.toUpperCase(),
//             style: const TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 2,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Styled Text Field ──
// class _StyledField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final IconData icon;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validator;
//   final int maxLines;
//   final String? hint;
//   final bool readOnly;

//   const _StyledField({
//     required this.label,
//     required this.controller,
//     required this.icon,
//     this.keyboardType,
//     this.validator,
//     this.maxLines = 1,
//     this.hint,
//     this.readOnly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: validator,
//       maxLines: maxLines,
//       readOnly: readOnly,
//       style: TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: readOnly ? Colors.grey[500] : Colors.black,
//       ),
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
//         labelStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
//         prefixIcon: Icon(icon, size: 18, color: Colors.grey[600]),
//         filled: true,
//         fillColor: readOnly ? Colors.grey[100] : Colors.grey[50],
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.grey.shade200),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: readOnly ? Colors.grey.shade200 : Colors.black,
//             width: readOnly ? 1 : 1.5,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.red, width: 1.5),
//         ),
//       ),
//     );
//   }
// }
























import 'dart:io';
import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DesignerEditProfile extends StatefulWidget {
  const DesignerEditProfile({super.key});

  @override
  State<DesignerEditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<DesignerEditProfile> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final _nameController   = TextEditingController();
  final _emailController  = TextEditingController();
  final _mobileController = TextEditingController();
  final _aboutController  = TextEditingController();

  bool _isInitialized = false;

  // ── Remote image URL with cache-busting timestamp ──
  String? get _remoteImageUrl {
    final raw = context.read<UserProfileProvider>().user?.profileImage;
    if (raw == null || raw.isEmpty) return null;
    final base = raw.startsWith('http') ? raw : 'http://31.97.228.17:4077/$raw';
    return '$base?t=${DateTime.now().millisecondsSinceEpoch}';
  }

  // ── Plain base URL used for cache eviction ──
  String? get _remoteImageBaseUrl {
    final raw = context.read<UserProfileProvider>().user?.profileImage;
    if (raw == null || raw.isEmpty) return null;
    return raw.startsWith('http') ? raw : 'http://31.97.228.17:4077/$raw';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().fetchProfile();
    });
  }

  void _populateFields(UserProfileProvider provider) {
    if (_isInitialized) return;
    final user = provider.user;
    if (user == null) return;

    _nameController.text   = user.name;
    _emailController.text  = user.email;
    _mobileController.text = user.mobile ?? '';
    _aboutController.text  = user.about  ?? '';

    _isInitialized = true;
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Choose Photo',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: Colors.black),
              title: const Text('Choose from Gallery',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () async {
                Navigator.pop(ctx);
                final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 80);
                if (image != null) {
                  await _handlePickedImage(File(image.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: Colors.black),
              title: const Text('Take a Photo',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () async {
                Navigator.pop(ctx);
                final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 80);
                if (image != null) {
                  await _handlePickedImage(File(image.path));
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePickedImage(File imageFile) async {
    setState(() => _pickedImage = imageFile);

    final imageProvider = context.read<ProfileImageProvider>();
    imageProvider.reset();

    // Capture the old base URL BEFORE uploading (for cache eviction)
    final oldBaseUrl = _remoteImageBaseUrl;

    final success = await imageProvider.updateProfileImage(imageFile);

    if (!mounted) return;

    if (success) {
      // Evict the old cached image using the plain base URL (no timestamp)
      if (oldBaseUrl != null) {
        NetworkImage(oldBaseUrl).evict();
      }

      // Refresh profile so the new URL is reflected
      await context.read<UserProfileProvider>().fetchProfile();

      // Clear the local file preview — _remoteImageUrl will now serve
      // the fresh URL with a new timestamp
      setState(() => _pickedImage = null);
    } else {
      // Revert local preview on failure
      setState(() => _pickedImage = null);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? imageProvider.successMessage
              : imageProvider.errorMessage,
        ),
        backgroundColor: success ? Colors.black : Colors.red,
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<UserProfileProvider>();

    final success = await provider.updateProfile(
      name:  _nameController.text.trim(),
      email: _emailController.text.trim(),
      about: _aboutController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Profile saved successfully'
              : (provider.errorMessage ?? 'Failed to save profile'),
        ),
        backgroundColor: success ? Colors.black : Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        if (provider.fetchState == ProfileState.success) {
          _populateFields(provider);
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'Georgia',
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: 0.4,
              ),
            ),
            centerTitle: true,
            actions: [
              provider.isUpdateLoading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.black),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: _saveProfile,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
            ],
          ),
          body: provider.isFetchLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black))
              : provider.fetchState == ProfileState.error
                  ? _ErrorView(
                      message: provider.errorMessage ?? 'Something went wrong',
                      onRetry: provider.fetchProfile,
                    )
                  : _buildForm(provider),
        );
      },
    );
  }

  Widget _buildForm(UserProfileProvider provider) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ── Header Banner with Avatar ──
            Consumer<ProfileImageProvider>(
              builder: (context, imageProvider, _) {
                final remoteUrl = _remoteImageUrl;

                return Container(
                  width: double.infinity,
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: imageProvider.isLoading ? null : _pickImage,
                        child: Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2.5),
                                color: Colors.grey[800],
                              ),
                              child: ClipOval(
                                child: _pickedImage != null
                                    ? Image.file(
                                        _pickedImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : remoteUrl != null
                                        ? Image.network(
                                            remoteUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.person,
                                                    size: 40,
                                                    color: Colors.white54),
                                          )
                                        : const Icon(Icons.person,
                                            size: 40,
                                            color: Colors.white54),
                              ),
                            ),

                            // Upload progress overlay
                            if (imageProvider.isLoading)
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Camera icon badge
                            if (!imageProvider.isLoading)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.camera_alt,
                                      size: 14, color: Colors.black),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        imageProvider.isLoading
                            ? 'Uploading…'
                            : 'Tap to change photo',
                        style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            /// ── Personal Info Section ──
            const _SectionHeader(title: 'Personal Info'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _StyledField(
                    label: 'Full Name',
                    controller: _nameController,
                    icon: Icons.person_outline,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 14),
                  _StyledField(
                    label: 'Mobile Number',
                    controller: _mobileController,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    readOnly: true,
                  ),
                  const SizedBox(height: 14),
                  _StyledField(
                    label: 'Email Address',
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Email is required' : null,
                  ),
                  const SizedBox(height: 14),
                  _StyledField(
                    label: 'About',
                    controller: _aboutController,
                    icon: Icons.info_outline,
                    hint: 'Tell clients about yourself…',
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            /// ── Save Button ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: provider.isUpdateLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[400],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: provider.isUpdateLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          'SAVE CHANGES',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ── Error View ──
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
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
    );
  }
}

// ── Section Header ──
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(width: 3, height: 16, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Styled Text Field ──
class _StyledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final String? hint;
  final bool readOnly;

  const _StyledField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.hint,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      readOnly: readOnly,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: readOnly ? Colors.grey[500] : Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
        prefixIcon: Icon(icon, size: 18, color: Colors.grey[600]),
        filled: true,
        fillColor: readOnly ? Colors.grey[100] : Colors.grey[50],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: readOnly ? Colors.grey.shade200 : Colors.black,
            width: readOnly ? 1 : 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}