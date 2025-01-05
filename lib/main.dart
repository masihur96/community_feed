import 'package:community_feed_app/utils/dark_theme_style.dart';
import 'package:community_feed_app/utils/light_theme_style.dart';
import 'package:community_feed_app/viewmodels/auth_viewmodel.dart';
import 'package:community_feed_app/viewmodels/post_viewmodel.dart';
import 'package:community_feed_app/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
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
      title: 'Community Feed App',
      theme: buildLightTheme(context),
      darkTheme: buildDarkTheme(context),
      themeMode: ThemeMode.light,
      home: const LoginScreen(),
    );
  }
}
