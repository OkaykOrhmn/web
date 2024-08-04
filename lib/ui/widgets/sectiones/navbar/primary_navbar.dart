import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/main.dart';

class PrimaryNavbar extends StatelessWidget {
  const PrimaryNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: screenIndexed,
      builder: (context, child) => Container(
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
      onTap: () => screenIndexed.value = position,
      child: screenIndexed.value == position
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
