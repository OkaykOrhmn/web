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
        title: const Text('Title'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.square_grid_2x2_fill,
              color: Colors.blueAccent,
            )),
        actions: [
          IconButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell_fill,
                color: Colors.blueAccent,
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
