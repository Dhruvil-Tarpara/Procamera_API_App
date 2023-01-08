import 'package:flutter/material.dart';
import 'package:procamera/screens/details_page.dart';
import 'package:procamera/screens/post_page.dart';
import 'package:procamera/screens/splash_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        'postPage': (context) => const PostScreen(),
        'details' : (context) => const DetailsPage(),
      },
    ),
  );
}
