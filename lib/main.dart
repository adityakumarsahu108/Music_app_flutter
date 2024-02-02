import 'package:flutter/material.dart';
import 'package:gym_music_app/models/playlist_provider.dart';
import 'package:gym_music_app/pages/load_page.dart';

import 'package:gym_music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaylistProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
