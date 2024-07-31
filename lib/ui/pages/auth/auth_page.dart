// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late AnimationController addToCartPopUpAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 900));

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 2),
    end: const Offset(0, 0.1),
  ).animate(CurvedAnimation(
    parent: addToCartPopUpAnimationController,
    curve: Curves.easeIn,
  ));

  late final Animation<double> animation =
      Tween<double>(begin: 32, end: 46).animate(CurvedAnimation(
    parent: addToCartPopUpAnimationController,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: mainBackground(context: context, children: [
          Center(
              child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 32, horizontal: animation.value),
              child: login(context),
            ),
          )),
          Center(
            child: SlideTransition(
              position: _offsetAnimation,
              child: register(context),
            ),
          )
        ]),
      ),
    );
  }

  Container register(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(0.5, 0.5))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              // await addToCartPopUpAnimationController.forward();
              await addToCartPopUpAnimationController.reverse();
            },
            child: const Text(
              "SIGN IN",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "username",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "username",
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(
            height: 46,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Text(
              'START',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Column login(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: Offset(0.5, 0.5))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  // await addToCartPopUpAnimationController.forward();
                  await addToCartPopUpAnimationController.reverse();
                },
                child: const Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "username",
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "username",
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                  'START',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            await addToCartPopUpAnimationController.forward();
            // await addToCartPopUpAnimationController.reverse();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
                border: Border(
                  bottom: BorderSide(color: Colors.blueAccent, width: 2),
                  left: BorderSide(color: Colors.blueAccent, width: 2),
                  right: BorderSide(color: Colors.blueAccent, width: 2),
                )),
            alignment: Alignment.center,
            child: const Text(
              "CREATE NEW",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w900),
            ),
          ),
        )
      ],
    );
  }

  Stack mainBackground({
    required final BuildContext context,
    required final List<Widget> children,
  }) {
    return Stack(
      children: [
        Positioned(
            left: -MediaQuery.sizeOf(context).width / 2.2,
            top: -MediaQuery.sizeOf(context).height / 10,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(30 / 360),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 1.5,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(46)),
              ),
            )),
        Positioned(
            right: -46,
            bottom: -MediaQuery.sizeOf(context).height / 10,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(30 / 360),
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height / 3,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(46)),
              ),
            )),
        Positioned(
            top: -180,
            right: 46,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(50 / 360),
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height / 3,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(46),
                    border: Border.all(color: Colors.orangeAccent, width: 18)),
              ),
            )),
        Positioned(
            bottom: 80,
            right: -180,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(35 / 360),
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height / 3,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(46),
                    border: Border.all(color: Colors.orangeAccent, width: 18)),
              ),
            )),
        ...children
      ],
    );
  }
}
