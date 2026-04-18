// // import 'package:brublaapp/views/splash/splash_screen.dart';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'BRUBLA',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //       ),
// //       debugShowCheckedModeBanner: false,
// //       home: const SplashScreen(),
// //     );
// //   }
// // }











// import 'package:brublaapp/provider/navbar/navbar_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:brublaapp/views/splash/splash_screen.dart';


// void main() {
//   runApp(const MyAppWrapper());
// }

// class MyAppWrapper extends StatelessWidget {
//   const MyAppWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<BottomNavbarProvider>(
//           create: (_) => BottomNavbarProvider(),
//         ),


//       ],
//       child: const MyApp(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BRUBLA',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//         ),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }









// lib/main.dart

import 'package:brublaapp/provider/dessigner/designer_provider.dart';
import 'package:brublaapp/provider/navbar/navbar_provider.dart';
import 'package:brublaapp/provider/navbar/tailor/tailor_navbar_provider.dart';
import 'package:brublaapp/provider/stylist/stylist_navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brublaapp/views/splash/splash_screen.dart';

void main() {
  runApp(const MyAppWrapper());
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TailorNavbarProvider>(
          create: (_) => TailorNavbarProvider(),
        ),
        ChangeNotifierProvider<DesignerNavbarProvider>(
          create: (_) => DesignerNavbarProvider(),
        ),
        ChangeNotifierProvider<StylistNavbarProvider>(
          create: (_) => StylistNavbarProvider(),
        ),
        ChangeNotifierProvider<UserNavbarProvider>(
          create: (_) => UserNavbarProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRUBLA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}