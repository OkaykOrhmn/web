import 'package:flutter/material.dart';

class SplashBackground extends StatefulWidget {
  final BuildContext context;
  final List<Widget> children;
  const SplashBackground(
      {super.key, required this.context, required this.children});

  @override
  State<SplashBackground> createState() => _SplashBackgroundState();
}

class _SplashBackgroundState extends State<SplashBackground> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
