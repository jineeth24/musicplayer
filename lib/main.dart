import 'package:flutter/material.dart';
import 'package:musicp/models/play_list_provider.dart';
import 'package:musicp/screens/home_screen.dart';

import 'package:musicp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(

    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => PlaylistProvider()),
    ],
    child:const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: HomeScreen(),
    );
  }
}
