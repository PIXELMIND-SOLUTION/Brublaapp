// import 'package:flutter/material.dart';

// class CategoryTabs extends StatefulWidget {
//   const CategoryTabs({super.key});

//   @override
//   State<CategoryTabs> createState() => _CategoryTabsState();
// }

// class _CategoryTabsState extends State<CategoryTabs> {
//   int _selectedTab = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: Row(
//         children: [
//           _tabItem('All', _selectedTab == 0, () {
//             setState(() => _selectedTab = 0);
//           }),
//           const SizedBox(width: 16),
//           _tabItem('Men', _selectedTab == 1, () {
//             setState(() => _selectedTab = 1);
//           }),
//           const SizedBox(width: 16),
//           _tabItem('Women', _selectedTab == 2, () {
//             setState(() => _selectedTab = 2);
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _tabItem(String text, bool active, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: active ? FontWeight.bold : FontWeight.normal,
//           color: active ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
//         ),
//       ),
//     );
//   }
// }


























import 'package:brublaapp/provider/category/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, _) {
        final categoryNames = provider.activeCategories.map((c) => c.name).toList();

        final tabs = ['All', ...categoryNames];

        if (_selectedTab >= tabs.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => _selectedTab = 0);
            provider.setTabFilter(null);
          });
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(tabs.length, (i) {
                final isLast = i == tabs.length - 1;
                return Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 16),
                  child: _tabItem(
                    tabs[i],
                    _selectedTab == i,
                    () => _selectTab(i, tabs[i]),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  void _selectTab(int index, String tabName) {
    setState(() => _selectedTab = index);
    context.read<CategoryProvider>().setTabFilter(
          tabName == 'All' ? null : tabName,
        );
  }

  Widget _tabItem(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 150),
        style: TextStyle(
          fontSize: 14,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? Colors.black : Colors.grey,
        ),
        child: Text(text),
      ),
    );
  }
}