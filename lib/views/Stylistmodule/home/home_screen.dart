
import 'package:brublaapp/views/Stylistmodule/home/notification_screen.dart';
import 'package:brublaapp/views/Stylistmodule/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class StylistHomeScreen extends StatefulWidget {
  const StylistHomeScreen({super.key});

  @override
  State<StylistHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StylistHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  
  List<DesignModel> designs = [];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNewOrderModal(context);
      _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _addDesign(DesignModel design) {
    setState(() {
      designs.insert(0, design);
    });
  }

  void _showNewOrderModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 520),
      transitionBuilder: (ctx, anim, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
      pageBuilder: (ctx, _, __) => const _NewOrderModal(),
    );
  }

  void _showAddDesignForm(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 480),
      transitionBuilder: (ctx, anim, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
      pageBuilder: (ctx, _, __) => _AddDesignForm(onDesignAdded: _addDesign),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F3),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 26),
                    _buildGreetingRow(),
                    const SizedBox(height: 28),
                    _buildOrderStatsRow(),
                    const SizedBox(height: 32),
                    _buildSectionLabel('MY DESIGNS'),
                    const SizedBox(height: 16),
                    _buildDesignsSection(),
                    const SizedBox(height: 32),
                    _buildSectionLabel('RECENT ORDERS'),
                    const SizedBox(height: 14),
                    _buildRecentOrders(),
                    const SizedBox(height: 30),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: 0,
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(
        children: [
          // Container(
          //   width: 32,
          //   height: 32,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.white, width: 1.5),
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          //   child:
          //       const Icon(Icons.content_cut, color: Colors.white, size: 16),
          // ),
          const SizedBox(width: 10),
          const Text(
            'BRUBLA DESIGNER',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Georgia',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon:
              const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DesignerNotificationsScreen()));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StylistProfileScreen()));
            },
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey.shade800,
              child: ClipOval(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr1Bd7-fuenmrLFu2S7exfcg0f1pGOe-Q79A&s',
                  width: 34,
                  height: 34,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Text(
                    'T',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Greeting ─────────────────────────────────────────────────────────────

  Widget _buildGreetingRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Morning,',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black45,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Melvin.',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   padding:
        //       const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        //   decoration: BoxDecoration(
        //     color: Colors.black,
        //     borderRadius: BorderRadius.circular(30),
        //   ),
        //   child: const Row(
        //     children: [
        //       Icon(Icons.circle, color: Color(0xFF7FFF45), size: 8),
        //       SizedBox(width: 6),
        //       Text(
        //         'Open Shop',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w600,
        //           letterSpacing: 0.5,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  // ── Stats ─────────────────────────────────────────────────────────────────

  Widget _buildOrderStatsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _StatCard(
            label: 'Pending',
            count: '12',
            icon: Icons.hourglass_top_rounded,
            accent: const Color(0xFFFFD700),
            isLarge: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              _StatCard(
                label: 'Completed',
                count: '84',
                icon: Icons.check_circle_outline_rounded,
                accent: Colors.white,
                isLarge: false,
              ),
              const SizedBox(height: 12),
              _StatCard(
                label: 'Rejected',
                count: '5',
                icon: Icons.cancel_outlined,
                accent: Colors.black,
                isLarge: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Section Label ─────────────────────────────────────────────────────────

  Widget _buildSectionLabel(String text) {
    return Row(
      children: [
        Container(width: 3, height: 14, color: Colors.black),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }

  // ── Designs Section ───────────────────────────────────────────────────────

  Widget _buildDesignsSection() {
    return Column(
      children: [
        // Add Design CTA
        GestureDetector(
          onTap: () => _showAddDesignForm(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'ADD NEW DESIGN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Horizontal design cards
        if (designs.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Icon(Icons.inbox_outlined, size: 48, color: Colors.black26),
                const SizedBox(height: 12),
                Text(
                  'No designs yet',
                  style: TextStyle(color: Colors.black45, fontSize: 14),
                ),
                Text(
                  'Tap "ADD NEW DESIGN" to get started',
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: designs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final d = designs[i];
                return _DesignCard(
                  title: d.name,
                  category: d.category,
                  tag: d.keywords.isNotEmpty ? d.keywords.first : 'New',
                  imageFile: d.imageFile,
                  dims: '${d.width}×${d.height} in',
                );
              },
            ),
          ),
      ],
    );
  }

  // ── Recent Orders ─────────────────────────────────────────────────────────

  Widget _buildRecentOrders() {
    final orders = [
      {
        'name': 'Arjun Menon',
        'item': 'Formal Shirt',
        'date': 'Apr 14',
        'status': 'pending',
        'avatar': 'https://i.pravatar.cc/80?img=11',
      },
      {
        'name': 'Ravi Kumar',
        'item': 'Wedding Suit',
        'date': 'Apr 13',
        'status': 'completed',
        'avatar': 'https://i.pravatar.cc/80?img=32',
      },
      {
        'name': 'Priya Nair',
        'item': 'Blouse',
        'date': 'Apr 12',
        'status': 'rejected',
        'avatar': 'https://i.pravatar.cc/80?img=47',
      },
      {
        'name': 'Suresh Das',
        'item': 'Kurta Set',
        'date': 'Apr 11',
        'status': 'completed',
        'avatar': 'https://i.pravatar.cc/80?img=60',
      },
    ];
    return Column(
      children: orders
          .map(
            (o) => _OrderTile(
              name: o['name']!,
              item: o['item']!,
              date: o['date']!,
              status: o['status']!,
              avatarUrl: o['avatar']!,
            ),
          )
          .toList(),
    );
  }
}

// ─── Design Model ───────────────────────────────────────────────────────────────

class DesignModel {
  final String name;
  final String description;
  final String category;
  final List<String> keywords;
  final String width;
  final String height;
  final File? imageFile;
  final List<XFile>? images;

  DesignModel({
    required this.name,
    required this.description,
    required this.category,
    required this.keywords,
    required this.width,
    required this.height,
    this.imageFile,
    this.images,
  });
}

// ─── Design Card ───────────────────────────────────────────────────────────────

class _DesignCard extends StatelessWidget {
  final String title;
  final String category;
  final String tag;
  final File? imageFile;
  final String dims;

  const _DesignCard({
    required this.title,
    required this.category,
    required this.tag,
    this.imageFile,
    required this.dims,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: 155,
                        height: 130,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 155,
                        height: 130,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_outlined,
                            color: Colors.black26, size: 40),
                      ),
                // Tag chip
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.82),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontFamily: 'Georgia',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                          fontSize: 10, color: Colors.black45),
                    ),
                    const Spacer(),
                    const Icon(Icons.straighten_rounded,
                        size: 10, color: Colors.black38),
                    const SizedBox(width: 3),
                    Text(
                      dims,
                      style: const TextStyle(
                          fontSize: 9, color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Add Design Form ──────────────────────────────────────────────────────────

class _AddDesignForm extends StatefulWidget {
  final Function(DesignModel) onDesignAdded;

  const _AddDesignForm({required this.onDesignAdded});

  @override
  State<_AddDesignForm> createState() => _AddDesignFormState();
}

class _AddDesignFormState extends State<_AddDesignForm> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = [
    'Bridal',
    'Formal',
    'Traditional',
    'Casual',
    'Party Wear',
    'Kids',
  ];

  final List<String> _allKeywords = [
    'Sale',
    'Festival',
    'New Arrival',
    'Trending',
    'Limited',
    'Exclusive',
    'Custom',
    'Seasonal',
  ];
  final Set<String> _selectedKeywords = {};

  List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages = images;
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void _submitDesign() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter design name'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please select a category'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please select at least one image'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final newDesign = DesignModel(
      name: _nameController.text,
      description: _descController.text,
      category: _selectedCategory!,
      keywords: _selectedKeywords.toList(),
      width: _widthController.text.isEmpty ? 'Standard' : _widthController.text,
      height: _heightController.text.isEmpty ? 'Standard' : _heightController.text,
      imageFile: File(_selectedImages.first.path),
      images: _selectedImages,
    );

    widget.onDesignAdded(newDesign);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Design saved successfully'),
        duration: Duration(seconds: 2),
      ),
    );
    
    Navigator.of(context).pop();
  }

  InputDecoration _fieldDecor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black45,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
      prefixIcon: Icon(icon, color: Colors.black54, size: 18),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.black, width: 1.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.92,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F3),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle + header
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(22, 14, 22, 0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.design_services_rounded,
                                  color: Colors.white, size: 13),
                              SizedBox(width: 6),
                              Text(
                                'ADD NEW DESIGN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.black12),
                            ),
                            child: const Icon(Icons.close_rounded,
                                size: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Scrollable form
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.fromLTRB(22, 0, 22, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      TextField(
                        controller: _nameController,
                        decoration: _fieldDecor(
                            'Design Name',
                            Icons.drive_file_rename_outline_rounded),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 14),

                      // Category dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            isExpanded: true,
                            hint: Row(
                              children: [
                                const Icon(Icons.category_outlined,
                                    color: Colors.black54, size: 18),
                                const SizedBox(width: 8),
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                            items: _categories
                                .map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(
                                        c,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) =>
                                setState(() => _selectedCategory = val),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Description
                      TextField(
                        controller: _descController,
                        maxLines: 3,
                        decoration: _fieldDecor(
                          'Description',
                          Icons.notes_rounded,
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 14),

                      // Image upload area
                      _buildSectionLabel('IMAGES'),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _pickImages,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Colors.white,
                                    size: 22),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _selectedImages.isNotEmpty
                                    ? '${_selectedImages.length} image${_selectedImages.length > 1 ? 's' : ''} selected'
                                    : 'Tap to upload images',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedImages.isNotEmpty
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'JPG, PNG up to 10MB each',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Keywords
                      _buildSectionLabel('KEYWORDS'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _allKeywords.map((kw) {
                          final selected =
                              _selectedKeywords.contains(kw);
                          return GestureDetector(
                            onTap: () => setState(() {
                              if (selected) {
                                _selectedKeywords.remove(kw);
                              } else {
                                _selectedKeywords.add(kw);
                              }
                            }),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: selected
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.circular(30),
                                border: Border.all(
                                  color: selected
                                      ? Colors.black
                                      : Colors.black26,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (selected) ...[
                                    const Icon(
                                        Icons.check_rounded,
                                        size: 12,
                                        color: Colors.white),
                                    const SizedBox(width: 4),
                                  ],
                                  Text(
                                    kw,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: selected
                                          ? Colors.white
                                          : Colors.black,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),

                      // Dimensions
                      _buildSectionLabel('DIMENSIONS'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _widthController,
                              keyboardType: TextInputType.number,
                              decoration: _fieldDecor(
                                  'Width (in)',
                                  Icons.swap_horiz_rounded),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.close_rounded,
                                color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              decoration: _fieldDecor(
                                  'Height (in)',
                                  Icons.swap_vert_rounded),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Submit button
                      GestureDetector(
                        onTap: _submitDesign,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save_alt_rounded,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 10),
                              Text(
                                'SAVE DESIGN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Row(
      children: [
        Container(width: 3, height: 13, color: Colors.black),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}

// ─── Stat Card ─────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final String count;
  final IconData icon;
  final Color accent;
  final bool isLarge;

  const _StatCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.accent,
    required this.isLarge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLarge ? 184 : 86,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isLarge
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.black87, size: 18),
                ),
                const Spacer(),
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontFamily: 'Georgia',
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accent == Colors.white
                        ? Colors.black.withOpacity(0.08)
                        : Colors.black.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      Icon(icon, color: Colors.black87, size: 16),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      count,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontFamily: 'Georgia',
                      ),
                    ),
                    Text(
                      label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.black45,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

// ─── Order Tile ────────────────────────────────────────────────────────────────

class _OrderTile extends StatelessWidget {
  final String name;
  final String item;
  final String date;
  final String status;
  final String avatarUrl;

  const _OrderTile({
    required this.name,
    required this.item,
    required this.date,
    required this.status,
    required this.avatarUrl,
  });

  Color get _statusBg {
    switch (status) {
      case 'completed':
        return Colors.black.withOpacity(0.06);
      case 'rejected':
        return Colors.black.withOpacity(0.04);
      default:
        return const Color(0xFFFFD700).withOpacity(0.18);
    }
  }

  Color get _statusText {
    switch (status) {
      case 'completed':
        return Colors.black87;
      case 'rejected':
        return Colors.black38;
      default:
        return const Color(0xFF7A6200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 0.8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: Colors.grey.shade300,
            child: ClipOval(
              child: Image.network(
                avatarUrl,
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 42,
                  height: 42,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      name[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item,
                  style: const TextStyle(
                      color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: status == 'completed'
                        ? Colors.black26
                        : status == 'rejected'
                            ? Colors.black12
                            : Colors.transparent,
                  ),
                ),
                child: Text(
                  status[0].toUpperCase() + status.substring(1),
                  style: TextStyle(
                    color: _statusText,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                    color: Colors.black38, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── New Order Modal ───────────────────────────────────────────────────────────

class _NewOrderModal extends StatelessWidget {
  const _NewOrderModal();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 36),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F3),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // NEW ORDER badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.fiber_new_rounded,
                        color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'NEW ORDER REQUEST',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Designer dress preview card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Designer dress image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=300&q=80',
                        width: 90,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 90,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                          child: const Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.checkroom_rounded,
                                  color: Colors.white, size: 36),
                              SizedBox(height: 6),
                              Text(
                                'DESIGNER',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            width: 90,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black38,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // Designer tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'DESIGNER PIECE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Bridal Lehenga\nEmbroidered',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontFamily: 'Georgia',
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _SpecRow(
                            icon: Icons.palette_outlined,
                            label: 'Color',
                            value: 'Ivory White',
                          ),
                          _SpecRow(
                            icon: Icons.straighten_rounded,
                            label: 'Size',
                            value: '42×58 in',
                          ),
                          _SpecRow(
                            icon: Icons.texture_rounded,
                            label: 'Fabric',
                            value: 'Raw Silk',
                          ),
                          _SpecRow(
                            icon: Icons.tag_rounded,
                            label: 'Keyword',
                            value: 'Festival',
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                '₹18,500',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  fontFamily: 'Georgia',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black
                                      .withOpacity(0.07),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                  border: Border.all(
                                      color: Colors.black12),
                                ),
                                child: const Text(
                                  'Adv: ₹5,000',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Customer info row
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black, width: 0.8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade300,
                      child: ClipOval(
                        child: Image.network(
                          'https://i.pravatar.cc/80?img=11',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 40,
                            height: 40,
                            color: Colors.black,
                            child: const Center(
                              child: Text(
                                'A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arjun Menon',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Delivery by Apr 20, 2025',
                            style: TextStyle(
                                color: Colors.black45, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withOpacity(0.22),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'URGENT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Color(0xFF7A6200),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black,
                            content: Text('Order Declined'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(
                            const Duration(milliseconds: 500), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.black, width: 1.5),
                        ),
                        child: const Center(
                          child: Text(
                            'DECLINE',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black,
                            content: Text('Order Accepted Successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(
                            const Duration(milliseconds: 500), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_rounded,
                                color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'ACCEPT ORDER',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Spec Row ──────────────────────────────────────────────────────────────────

class _SpecRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SpecRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 11, color: Colors.black38),
          const SizedBox(width: 4),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 11, color: Colors.black38),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}