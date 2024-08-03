// ignore_for_file: library_private_types_in_public_api, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/bloc/auth/auth_bloc.dart';
import 'package:web/core/enum/dialogs_status.dart';
import 'package:web/data/model/login_model.dart';
import 'package:web/data/storage/token.dart';
import 'package:web/ui/pages/home/home_page.dart';
import 'package:web/ui/widgets/background/splash_background.dart';
import 'package:web/ui/widgets/dialog/dialog_handler.dart';
import 'package:web/ui/widgets/snackbar/snackbar_handler.dart';

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

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              await SnackBarHandler(context)
                  .show("با موفقیت وارد شدید 😃", DialogStatus.success, false);
              await setToken(state.response.token.toString());
              await Future.delayed(
                Duration.zero,
                () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                },
              );
            } else if (state is AuthFail) {
              await SnackBarHandler(context)
                  .show(state.message, DialogStatus.error, false);
              Future.delayed(Duration.zero,
                  () => Navigator.of(context, rootNavigator: true).pop());
            } else if (state is AuthLoading) {
              await DialogHandler(context).showLoadingDialog();
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: SplashBackground(context: context, children: [
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
            );
          },
        ),
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
          const Text(
            "CREATE NEW",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          TextField(
            controller: username,
            decoration: const InputDecoration(
              hintText: "username",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(
              hintText: "password",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: rePassword,
            decoration: const InputDecoration(
              hintText: "repeat password",
            ),
          ),
          const SizedBox(
            height: 46,
          ),
          InkWell(
            onTap: () {
              if (username.text.isEmpty ||
                  password.text.isEmpty ||
                  username.text.length < 4 ||
                  password.text.length < 8) {
                SnackBarHandler(context).show(
                    "لطفا فیلد هارا پر کنید!!", DialogStatus.warning, false);
              } else {
                User user = User();
                user.username = username.text;
                user.password = password.text;
                if (user.password == rePassword.text) {
                  context.read<AuthBloc>().add(AuthRegister(user: user));
                } else {
                  SnackBarHandler(context).show("رمز ها با هم مطابقت ندارد!!",
                      DialogStatus.warning, false);
                }
              }
            },
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const Text(
                'DONE',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
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
        GestureDetector(
          onTap: () async {
            // await addToCartPopUpAnimationController.forward();
            await addToCartPopUpAnimationController.reverse();
          },
          child: Container(
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
                const Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                TextField(
                  controller: username,
                  decoration: const InputDecoration(
                    hintText: "username",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: password,
                  decoration: const InputDecoration(
                    hintText: "password",
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
                InkWell(
                  onTap: () {
                    if (username.text.isEmpty ||
                        password.text.isEmpty ||
                        username.text.length < 4 ||
                        password.text.length < 8) {
                      SnackBarHandler(context).show("لطفا فیلد هارا پر کنید!!",
                          DialogStatus.warning, false);
                    } else {
                      User user = User();
                      user.username = username.text;
                      user.password = password.text;
                      context.read<AuthBloc>().add(AuthLogin(user: user));
                    }
                  },
                  child: SizedBox(
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
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
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
}
