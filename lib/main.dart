import 'package:flutter/material.dart';
import 'home_page.dart';
import 'social_page.dart';
import 'quiz_social_easy.dart';
import 'quiz_social_hard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: {
        '/': (_) => HomePage(),
        '/social': (_) => SocialPage(),
        '/quiz_social_easy': (_) => QuizSocialEasyPage(),
        '/quiz_social_hard': (_) => QuizSocialHardPage(),
      },
      initialRoute: '/',
    );
  }
}
