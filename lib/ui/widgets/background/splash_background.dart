import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashBackground extends StatefulWidget {
  final BuildContext context;
  final List<Widget> children;
  const SplashBackground(
      {super.key, required this.context, required this.children});

  @override
  State<SplashBackground> createState() => _SplashBackgroundState();
}

class _SplashBackgroundState extends State<SplashBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController addToCartPopUpAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 900));

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-0.1, 0),
    end: const Offset(-0.5, -0.2),
  ).animate(CurvedAnimation(
    parent: addToCartPopUpAnimationController,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    addToCartPopUpAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
        Positioned(
            right: -46,
            bottom: -MediaQuery.sizeOf(context).height / 10,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(20 / 360),
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
        ...widget.children
      ],
    );
  }
}
