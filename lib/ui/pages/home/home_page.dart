// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/ui/pages/home/screens/cart_screen.dart';
import 'package:web/ui/pages/home/screens/categories_screen.dart';
import 'package:web/ui/pages/home/screens/home_screen.dart';
import 'package:web/ui/pages/home/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef1f1),
      body: SafeArea(
        child: IndexedStack(
          index: index,
          children: const [
            HomeScreen(),
            CategoriesScreen(),
            CartScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: Offset(0.5, 0.5))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navBtn(position: 0, icon: Icons.home_rounded, title: 'Home'),
            navBtn(
                position: 1,
                icon: CupertinoIcons.layers_fill,
                title: 'Categories'),
            navBtn(position: 2, icon: CupertinoIcons.cart_fill, title: 'Cart'),
            navBtn(
                position: 3,
                icon: CupertinoIcons.profile_circled,
                title: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget navBtn(
      {required final int position,
      required final IconData icon,
      required final String title}) {
    return InkWell(
      onTap: () => setState(() => index = position),
      child: index == position
          ? Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      icon,
                      size: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          : Icon(
              icon,
              size: 24,
              color: Colors.blueAccent,
            ),
    );
  }
}
