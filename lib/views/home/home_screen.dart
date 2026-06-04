// // ignore_for_file: deprecated_member_use

// import 'package:brublaapp/widgets/banner_widget.dart';
// import 'package:brublaapp/widgets/brubla_session_widget.dart';
// import 'package:brublaapp/widgets/category_session_widget.dart';
// import 'package:brublaapp/widgets/category_tabs_widget.dart';
// import 'package:brublaapp/widgets/most_sales_widget.dart';
// import 'package:brublaapp/widgets/recommended_widget.dart';
// import 'package:brublaapp/widgets/search_bar_widget.dart';
// import 'package:brublaapp/widgets/section_grid_widget.dart';
// import 'package:brublaapp/widgets/top_bar_widget.dart';
// import 'package:brublaapp/widgets/upcoming_drop_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:brublaapp/views/details/detail_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<String> _searchKeywords = [
//     'Shirts',
//     'Pants',
//     'Jeans',
//     'Jackets',
//     'Hoodies',
//     'Sneakers',
//     'Kurtas',
//   ];

//   final List<Map<String, dynamic>> _latestDesigns = [
//     {
//       'name': 'Tommy Shirts',
//       'price': '\$ 200/-',
//       'original': '\$ 747-',
//       'image': 'assets/homecard.png',
//       'selected': true,
//     },
//     {
//       'name': 'Tommy Shirts',
//       'price': '\$ 200/-',
//       'original': '\$ 747-',
//       'image': 'assets/homecard.png',
//       'selected': false,
//     },
//     {
//       'name': 'Tommy Shirts',
//       'price': '\$ 200/-',
//       'original': '\$ 747-',
//       'image': 'assets/homecard.png',
//       'selected': false,
//     },
//     {
//       'name': 'Tommy Shirts',
//       'price': '\$ 200/-',
//       'original': '\$ 747-',
//       'image': 'assets/homecard.png',
//       'selected': false,
//     },
//   ];

//   // final List<Map<String, dynamic>> _recommended = [
//   //   {
//   //     'name': 'Tommy Shirts',
//   //     'price': '\$ 200/-',
//   //     'original': '\$ 747-',
//   //     'image': 'assets/homecard.png',
//   //   },
//   //   {
//   //     'name': 'Tommy Shirts',
//   //     'price': '\$ 200/-',
//   //     'original': '\$ 747-',
//   //     'image': 'assets/homecard.png',
//   //   },
//   // ];

//   final List<Map<String, dynamic>> _mostSales = [
//     {
//       'name': 'Tommy Shirts',
//       'price': '\$ 200/-',
//       'original': '\$ 747-',
//       'image': 'assets/homecard.png',
//       'discount': '20% off',
//       'rating': '4.5/5',
//     },
//     {
//       'name': 'Tommy Shirts',
//       'price': '\$ 200/-',
//       'original': '\$ 747-',
//       'image': 'assets/homecard.png',
//       'discount': '20% off',
//       'rating': '4.5/5',
//     },
//   ];

//   Future<void> _onRefresh() async {
//     debugPrint('🔄 Home Screen Refreshed');

//     await Future.delayed(const Duration(seconds: 2));

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.green,
//           content: Text('✅ Page refreshed successfully'),
//         ),
//       );
//     }
//   }

//   Future<bool> _showExitDialog(BuildContext context) async {
//     final result = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Exit App'),
//         content: const Text('Are you sure you want to exit?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );
//     return result ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         final shouldExit = await _showExitDialog(context);
//         return shouldExit;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: _onRefresh,
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const TopBar(),
//                   SearchBarWidget(searchKeywords: _searchKeywords),
//                   SizedBox(height: 20),
//                   const CategoryTabs(),
//                   SizedBox(height: 20),
//                   const CategorySection(),
//                   SizedBox(height: 20),
//                   const BannerCarousel(),
//                   SectionGrid(
//                     title: 'Latest Designs',
//                     items: _latestDesigns,
//                     showSelected: true,
//                     onViewAllTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => DetailScreen()),
//                       );
//                     },
//                   ),
//                   // RecommendedRow(items: _recommended),

//                   const RecommendedRow(),
//                   const BrublaverseSection(),
//                   const UpcomingDropSection(),
//                   MostSalesSection(items: _mostSales),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }











///////////////// Above is the static data home screeen///////////







//////////////// Api integrated Home Screen///////////////




// ignore_for_file: deprecated_member_use, dangling_library_doc_comments

import 'package:brublaapp/widgets/banner_widget.dart';
import 'package:brublaapp/widgets/brubla_session_widget.dart';
import 'package:brublaapp/widgets/category_session_widget.dart';
import 'package:brublaapp/widgets/category_tabs_widget.dart';
import 'package:brublaapp/widgets/most_sales_widget.dart';
import 'package:brublaapp/widgets/recommended_widget.dart';
import 'package:brublaapp/widgets/search_bar_widget.dart';
import 'package:brublaapp/widgets/section_grid_widget.dart';
import 'package:brublaapp/widgets/top_bar_widget.dart';
import 'package:brublaapp/widgets/upcoming_drop_widget.dart';
import 'package:flutter/material.dart';
import 'package:brublaapp/views/details/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Key _sectionGridKey = UniqueKey();

  final List<String> _searchKeywords = [
    'Shirts',
    'Pants',
    'Jeans',
    'Jackets',
    'Hoodies',
    'Sneakers',
    'Kurtas',
  ];

  final List<Map<String, dynamic>> _mostSales = [
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'discount': '20% off',
      'rating': '4.5/5',
    },
    {
      'name': 'Tommy Shirts',
      'price': '\$ 200/-',
      'original': '\$ 747-',
      'image': 'assets/homecard.png',
      'discount': '20% off',
      'rating': '4.5/5',
    },
  ];

  Future<void> _onRefresh() async {
    debugPrint('🔄 Home Screen Refreshed');

    setState(() {
      _sectionGridKey = UniqueKey();
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('✅ Page refreshed successfully'),
        ),
      );
    }
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
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await _showExitDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBar(),
                  SearchBarWidget(searchKeywords: _searchKeywords),
                  const SizedBox(height: 20),
                  const CategoryTabs(),
                  const SizedBox(height: 20),
                  const CategorySection(),
                  const SizedBox(height: 20),
                  const BannerCarousel(),

                  SectionGrid(
                    key: _sectionGridKey,
                    title: 'Latest Designs',
                    showSelected: true,
                    onViewAllTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailScreen()),
                      );
                    },
                  ),

                  const RecommendedRow(),
                  const BrublaverseSection(),
                  const UpcomingDropSection(),
                  MostSalesSection(items: _mostSales),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
