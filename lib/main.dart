import 'package:flutter/material.dart';

import 'package:yo_movies/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yo Movie',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (BuildContext context) => HomePage(),
      },
    );
  }
}