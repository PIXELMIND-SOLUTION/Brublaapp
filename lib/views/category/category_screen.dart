// import 'package:flutter/material.dart';

// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),

//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),

//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: const Color.fromARGB(255, 0, 0, 0),
//           ),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'Categories',
//           style: TextStyle(
//             color: Color.fromARGB(255, 0, 0, 0),
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
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search for " Shirts "',
//                         hintStyle: TextStyle(color: Colors.grey.shade500),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   Icon(Icons.mic, color: Colors.grey.shade500),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ─── GRID ─────────────────────────
//             Expanded(
//               child: GridView.builder(
//                 itemCount: 6,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       // Circle container
//                       Container(
//                         height: 80,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(
//                             255,
//                             0,
//                             0,
//                             0,
//                           ), // light beige
//                           shape: BoxShape.circle,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(18),
//                           child: Image.asset(
//                             'assets/whiteshirt.png',
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 8),

//                       const Text(
//                         'Shirts',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Color.fromARGB(255, 0, 0, 0),
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
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> hints = ["Shirts", "Pants", "Jeans", "Shorts", "T-Shirts"];
  int currentIndex = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % hints.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentHint = hints[currentIndex];

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

            // ─── SEARCH BAR ───────────────────
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
                        // Highlighted Hint Text
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Actual TextField (transparent hint)
                        TextField(
                          decoration: const InputDecoration(
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

            // ─── GRID (same as yours) ─────────
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Column(
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
                          child: Image.asset(
                            'assets/whiteshirt.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Shirts',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
