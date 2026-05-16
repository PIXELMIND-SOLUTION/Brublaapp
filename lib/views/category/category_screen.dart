// import 'dart:async';
// import 'package:flutter/material.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final List<String> hints = ["Shirts", "Pants", "Jeans", "Shorts", "T-Shirts"];
//   int currentIndex = 0;

//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();

//     timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       setState(() {
//         currentIndex = (currentIndex + 1) % hints.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String currentHint = hints[currentIndex];

//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'Categories',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),

//             // ─── SEARCH BAR ───────────────────
//             Container(
//               height: 45,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: Colors.grey.shade500),
//                   const SizedBox(width: 8),

//                   Expanded(
//                     child: Stack(
//                       alignment: Alignment.centerLeft,
//                       children: [
//                         // Highlighted Hint Text
//                         IgnorePointer(
//                           child: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'Search for ',
//                                   style: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '"$currentHint"',
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         // Actual TextField (transparent hint)
//                         TextField(
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Icon(Icons.mic, color: Colors.grey.shade500),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ─── GRID (same as yours) ─────────
//             Expanded(
//               child: GridView.builder(
//                 itemCount: 6,
//                 gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 80,
//                         width: 80,
//                         decoration: const BoxDecoration(
//                           color: Colors.black,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(18),
//                           child: Image.asset(
//                             'assets/whiteshirt.png',
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'Shirts',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

















import 'dart:async';
import 'package:brublaapp/provider/category/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brublaapp/model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> hints = ["Shirts", "Pants", "Jeans", "Shorts", "T-Shirts"];
  int currentIndex = 0;
  Timer? _hintTimer;

  @override
  void initState() {
    super.initState();

    _hintTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % hints.length;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().fetchAllCategories();
    });
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentHint = hints[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade500),
                  const SizedBox(width: 8),

                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        IgnorePointer(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Search for ',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                                TextSpan(
                                  text: '"$currentHint"',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(Icons.mic, color: Colors.grey.shade500),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            provider.errorMessage ?? 'Something went wrong',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                provider.fetchAllCategories(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final categories = provider.activeCategories;
                  if (categories.isEmpty) {
                    return const Center(child: Text('No categories found.'));
                  }
                  return GridView.builder(
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final CategoryModel category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          provider.fetchSubcategories(category.id);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: category.image != null
                                    ? Image.network(
                                        category.image!,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                          Icons.category,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.category,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
