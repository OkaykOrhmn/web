// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/data/model/setting_button_model.dart';
import 'package:web/data/storage/token.dart';
import 'package:web/main.dart';
import 'package:web/ui/pages/like/like_page.dart';
import 'package:web/ui/pages/splash_page.dart';
import 'package:web/ui/widgets/media/image/primary_network_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<SettingButtonModel> btns = [
      SettingButtonModel(
          title: 'My Cart',
          icon: CupertinoIcons.cart_fill,
          click: () => screenIndexed.value = 2),
      SettingButtonModel(
        title: 'Wish List',
        icon: CupertinoIcons.heart_fill,
        click: () => Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => const LikePage(),
        )),
      ),
      SettingButtonModel(
        title: 'My Order',
        icon: CupertinoIcons.square_favorites_alt_fill,
      ),
      SettingButtonModel(title: 'Help', icon: CupertinoIcons.info_circle_fill),
      SettingButtonModel(title: 'Setting', icon: CupertinoIcons.settings),
      SettingButtonModel(
        title: 'Sign Out',
        icon: Icons.exit_to_app_outlined,
        color: Colors.redAccent,
        click: () async {
          await clearToken();
          Future.delayed(
            Duration.zero,
            () => Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const SplashPage(),
                ),
                (route) => true),
          );
        },
      ),
    ];
    return Column(
      children: [
        const SizedBox(
          height: 46,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 64,
                height: 64,
                child: PrimaryNetworkImage(
                  image:
                      'https://pics.craiyon.com/2023-11-26/oMNPpACzTtO5OVERUZwh3Q.webp',
                  borderRadius: BorderRadius.circular(18),
                )),
            const SizedBox(
              width: 24,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kianoosh Rahmanzaei"),
                Text("\$42,000.29"),
              ],
            )
          ],
        ),
        Container(
          width: MediaQuery.sizeOf(context).width / 1.2,
          margin: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
              color: const Color(0xffeef1f1),
              borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: btns.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => settingButtons(btn: btns[index]),
          ),
        )
      ],
    );
  }

  Widget settingButtons({required final SettingButtonModel btn}) {
    return InkWell(
      onTap: btn.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  btn.icon,
                  color: btn.color ?? Colors.blueAccent,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  btn.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: btn.color ?? Colors.blueAccent),
                )
              ],
            ),
            Icon(
              CupertinoIcons.forward,
              color: btn.color ?? Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
