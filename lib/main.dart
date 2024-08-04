import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/categories/categories_cubit.dart';
import 'package:web/core/cubit/profile/profile_cubit.dart';
import 'package:web/ui/pages/splash_page.dart';

final ValueNotifier<int> screenIndexed = ValueNotifier(0);

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
      BlocProvider<CategoriesCubit>(
        create: (context) {
          CategoriesCubit categoriesCubit = CategoriesCubit();
          categoriesCubit.getCategories();
          return categoriesCubit;
        },
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
