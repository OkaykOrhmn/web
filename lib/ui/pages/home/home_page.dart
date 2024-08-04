// ignore_for_file: library_private_types_in_public_api, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:web/main.dart';
import 'package:web/ui/pages/home/screens/cart_screen.dart';
import 'package:web/ui/pages/home/screens/categories_screen.dart';
import 'package:web/ui/pages/home/screens/home_screen.dart';
import 'package:web/ui/pages/home/screens/profile_screen.dart';
import 'package:web/ui/widgets/handler/dialog/dialog_handler.dart';
import 'package:web/ui/widgets/sectiones/navbar/primary_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (screenIndexed.value != 0) {
          screenIndexed.value = 0;
          return false;
        }
        await DialogHandler(context).showExitDialog();
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xffeef1f1),
          body: SafeArea(
            child: AnimatedBuilder(
              animation: screenIndexed,
              builder: (context, child) => IndexedStack(
                index: screenIndexed.value,
                children: const [
                  HomeScreen(),
                  CategoriesScreen(),
                  CartScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const PrimaryNavbar()),
    );
  }
}
