// import 'package:flutter/material.dart';
// import 'package:brublaapp/views/category/category_screen.dart';

// class CategorySection extends StatelessWidget {
//   const CategorySection({super.key});

//   final List<Map<String, dynamic>> _categories = const [
//     {'image': 'assets/whiteshirt.png', 'label': 'Shirts'},
//     {'image': 'assets/whitepant.png', 'label': 'Jeans for men'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Column(
//         children: [
//           _sectionHeader(
//             'Category',
//             context,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CategoryScreen()),
//               );
//             },
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: _categories
//                 .map(
//                   (cat) => Padding(
//                     padding: const EdgeInsets.only(right: 12),
//                     child: _categoryChip(cat),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionHeader(String title, BuildContext context, {VoidCallback? onTap}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 0, 0, 0),
//           ),
//         ),
//         GestureDetector(
//           onTap: onTap,
//           child: const Text(
//             'View all >>',
//             style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _categoryChip(Map<String, dynamic> cat) {
//     return Column(
//       children: [
//         Container(
//           width: 64,
//           height: 64,
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 0, 0, 0),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Image.asset(
//             cat['image'],
//             fit: BoxFit.contain,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           cat['label'] as String,
//           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }

// ignore_for_file: unused_element

import 'package:brublaapp/provider/category/category_provider.dart';
import 'package:brublaapp/widgets/subcategory_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brublaapp/model/category_model.dart';
import 'package:brublaapp/views/category/category_screen.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().fetchAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          _sectionHeader(
            'Category',
            context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          // _buildCategoryChips(context),
          _buildSubcategorySection(context),
        ],
      ),
    );
  }

  // Widget _buildCategoryChips(BuildContext context) {
  //   return Consumer<CategoryProvider>(
  //     builder: (context, provider, _) {
  //       if (provider.isLoading && provider.categories.isEmpty) {
  //         return const SizedBox(
  //           height: 90,
  //           child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
  //         );
  //       }

  //       if (provider.hasError && provider.categories.isEmpty) {
  //         return SizedBox(
  //           height: 90,
  //           child: Center(
  //             child: Text(
  //               provider.errorMessage ?? 'Failed to load categories',
  //               style: const TextStyle(fontSize: 12, color: Colors.red),
  //             ),
  //           ),
  //         );
  //       }

  //       final categories = provider.filteredCategories.take(6).toList();

  //       if (categories.isEmpty) {
  //         return const SizedBox(
  //           height: 90,
  //           child: Center(
  //             child: Text(
  //               'No categories',
  //               style: TextStyle(fontSize: 12, color: Colors.grey),
  //             ),
  //           ),
  //         );
  //       }

  //       return SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: categories.map((cat) {
  //             final isSelected = _selectedCategoryId == cat.id;
  //             return Padding(
  //               padding: const EdgeInsets.only(right: 12),
  //               child: _categoryChip(
  //                 cat,
  //                 isSelected: isSelected,
  //                 onTap: () => _onCategoryTap(context, cat),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildTabSubcategories(CategoryProvider provider) {
    if (provider.isLoading) {
      return const SizedBox(
        height: 90,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (provider.hasError) {
      return SizedBox(
        height: 90,
        child: Center(
          child: Text(
            provider.errorMessage ?? 'Failed to load subcategories',
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ),
      );
    }

    final subs = provider.activeSubcategoriesList;

    if (subs.isEmpty) {
      return const SizedBox(
        height: 90,
        child: Center(
          child: Text(
            'No subcategories',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: subs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final sub = subs[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubcategoryProductsScreen(
                    subcategoryId: sub.id,
                    subcategoryName: sub.name,
                    subcategoryImage: sub.image,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: _buildSubcategoryImage(sub),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 64,
                  child: Text(
                    sub.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    ///// This SingleChildScrollView is the used code////////////

    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: subs.map((sub) {
    //       return Padding(
    //         padding: const EdgeInsets.only(right: 12),
    //         child: Column(
    //           children: [
    //             AnimatedContainer(
    //               duration: const Duration(milliseconds: 200),
    //               width: 64,
    //               height: 64,
    //               padding: const EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 color: Colors.grey.shade100,
    //                 borderRadius: BorderRadius.circular(12),
    //                 border: Border.all(color: Colors.grey.shade200),
    //               ),
    //               child: _buildSubcategoryImage(sub),
    //             ),
    //             const SizedBox(height: 6),
    //             SizedBox(
    //               width: 64,
    //               child: Text(
    //                 sub.name,
    //                 textAlign: TextAlign.center,
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //                 style: const TextStyle(
    //                   fontSize: 11,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.black87,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // );
  }

  Widget _buildSubcategoryImage(SubcategoryModel sub) {
    final imageUrl = sub.image;

    if (imageUrl == null || imageUrl.isEmpty) {
      return Text(
        sub.name.isNotEmpty ? sub.name[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      );
    }

    final resolvedUrl = imageUrl.startsWith('http')
        ? imageUrl.replaceFirst('localhost', '31.97.228.17')
        : 'http://31.97.228.17:4077$imageUrl';

    return Image.network(
      resolvedUrl,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Text(
        sub.name.isNotEmpty ? sub.name[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildSubcategorySection(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        if (provider.selectedTabCategoryId != null) {
          return _buildTabSubcategories(provider);
        }
        // if (_selectedCategoryId == null) return const SizedBox.shrink();

        if (provider.isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        if (provider.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              provider.errorMessage ?? 'Failed to load subcategories',
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          );
        }

        final subs = provider.activeSubcategoriesList;

        if (subs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No subcategories available',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            const Text(
              'Subcategories',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: subs.map((sub) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubcategoryProductsScreen(
                              subcategoryId: sub.id,
                              subcategoryName: sub.name,
                            ),
                          ),
                        );
                      },
                      child: Chip(
                        label: Text(
                          sub.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: Colors.grey.shade100,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionHeader(
    String title,
    BuildContext context, {
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'View all >>',
            style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ],
    );
  }

  // Widget _categoryChip(
  //   CategoryModel cat, {
  //   required bool isSelected,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Column(
  //       children: [
  //         AnimatedContainer(
  //           duration: const Duration(milliseconds: 200),
  //           width: 64,
  //           height: 64,
  //           padding: const EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             color: isSelected
  //                 ? const Color.fromARGB(255, 0, 0, 0)
  //                 : Colors.grey.shade100,
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(
  //               color: isSelected ? Colors.black : Colors.grey.shade200,
  //               width: isSelected ? 2 : 1,
  //             ),
  //           ),
  //           // Use cat.imageUrl if your model has one, else show initials
  //           child: cat.image != null
  //               ? Image.network(
  //                   cat.image!,
  //                   fit: BoxFit.contain,
  //                   color: isSelected ? Colors.white : null,
  //                   errorBuilder: (_, __, ___) =>
  //                       _categoryInitial(cat.name, isSelected),
  //                 )
  //               : _categoryInitial(cat.name, isSelected),
  //         ),
  //         const SizedBox(height: 6),
  //         Text(
  //           cat.name,
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontWeight:
  //                 isSelected ? FontWeight.bold : FontWeight.w500,
  //             color: isSelected ? Colors.black : Colors.black87,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _categoryChip(
    CategoryModel cat, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: _buildCategoryImage(cat, isSelected),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 64,
            child: Text(
              cat.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryImage(CategoryModel cat, bool isSelected) {
    final imageUrl = cat.image;

    debugPrint('Category image URL for ${cat.name}: $imageUrl');

    if (imageUrl == null || imageUrl.isEmpty) {
      return _categoryInitial(cat.name, isSelected);
    }

    final resolvedUrl = imageUrl.startsWith('http')
        ? imageUrl
        : 'http://31.97.228.17:4077$imageUrl';

    return Image.network(
      resolvedUrl,
      fit: BoxFit.contain,
      color: isSelected ? Colors.white : null,
      colorBlendMode: isSelected ? BlendMode.srcIn : null,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: isSelected ? Colors.white : Colors.grey,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image error for ${cat.name}: $error');
        return _categoryInitial(cat.name, isSelected);
      },
    );
  }

  Widget _categoryInitial(String name, bool isSelected) {
    return Text(
      name.isNotEmpty ? name[0].toUpperCase() : '?',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isSelected ? Colors.white : Colors.black54,
      ),
    );
  }
}
