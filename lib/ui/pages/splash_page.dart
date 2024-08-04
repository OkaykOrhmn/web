import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/profile/profile_cubit.dart';
import 'package:web/data/storage/token.dart';
import 'package:web/ui/pages/auth/auth_page.dart';
import 'package:web/ui/pages/home/home_page.dart';
import 'package:web/ui/widgets/sectiones/background/splash_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController addToCartPopUpAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 600))
        ..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0, 0.2),
  ).animate(CurvedAnimation(
    parent: addToCartPopUpAnimationController,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 2400));
      final token = await getToken();
      if (kDebugMode) {
        print("token: $token");
      }
      if (token.isEmpty) {
        Future.delayed(
          Duration.zero,
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AuthPage(),
          )),
        );
      } else {
        await Future.delayed(
          Duration.zero,
          () async => await context.read<ProfileCubit>().getProfile(),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          } else if (state is ProfileFail) {
            Future.delayed(
              Duration.zero,
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AuthPage(),
              )),
            );
          }
        },
        builder: (context, state) {
          return SplashBackground(context: context, children: [
            Center(
              child: SlideTransition(
                position: _offsetAnimation,
                child: Icon(
                  CupertinoIcons.shopping_cart,
                  size: MediaQuery.sizeOf(context).width / 2,
                  color: Colors.orangeAccent,
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
