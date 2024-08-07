import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Shop',
          style: TextStyle(fontSize: 18, color: Colors.blueAccent),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //     style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffeef1f1)),
        //     onPressed: () {},
        //     icon: const Icon(
        //       CupertinoIcons.square_grid_2x2_fill,
        //       color: Colors.blueAccent,
        //       size: 18,
        //     )),
        actions: [
          IconButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffeef1f1)),
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell_fill,
                color: Colors.blueAccent,
                size: 18,
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
