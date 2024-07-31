import 'package:flutter/material.dart';
import 'package:web/ui/pages/auth/auth_page.dart';

void main() {
  runApp(const MyApp());
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
      home: const AuthPage(),
    );
  }
}


  // void _incrementCounter() async {
  //   try {
  //     final Dio _dio = Dio(BaseOptions(
  //       baseUrl: "http://10.0.2.2:8000",
  //       connectTimeout: const Duration(milliseconds: 30000),
  //       contentType: ContentType.json.toString(),
  //       responseType: ResponseType.json,
  //     ));
  //     _dio.interceptors.add(PrettyDioLogger());
  //     _dio.get('/product/news');
  //   } on DioException catch (e) {
  //     print(e);
  //   }

  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }
