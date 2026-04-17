import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),


      // ─── APP BAR ─────────────────────────────
      appBar: AppBar(
        // backgroundColor: Colors.grey.shade100,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),

        elevation: 0,
        leading:  IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ─── BODY ───────────────────────────────
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
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade500),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for " Shirts "',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.mic, color: Colors.grey.shade500),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ─── GRID ─────────────────────────
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Circle container
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0), // light beige
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Image.asset(
                            'assets/whiteshirt.png',
                            fit: BoxFit.contain,
                          ),
                          
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Shirts',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
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