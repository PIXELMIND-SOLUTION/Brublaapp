import 'package:brublaapp/helper/shared_preference.dart';
import 'package:brublaapp/provider/address/address_provider.dart';
import 'package:brublaapp/provider/category/category_provider.dart';
import 'package:brublaapp/provider/dessigner/designer_provider.dart';
import 'package:brublaapp/provider/navbar/navbar_provider.dart';
import 'package:brublaapp/provider/navbar/tailor/tailor_navbar_provider.dart';
import 'package:brublaapp/provider/stylist/stylist_navbar_provider.dart';
import 'package:brublaapp/views/navbar/auth/auth_provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_image_provider.dart';
import 'package:brublaapp/views/navbar/auth/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brublaapp/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
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

        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),

        ChangeNotifierProvider<UserProfileProvider>(
          create: (_) => UserProfileProvider(),
        ),

        ChangeNotifierProvider<ProfileImageProvider>(
          create: (_) => ProfileImageProvider(),
        ),

        ChangeNotifierProvider<AddressProvider>(
          create: (_) => AddressProvider(),
        ),

        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
