import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nokasa_user/screen/splash_screen.dart';
import 'package:nokasa_user/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoKasa',
      
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Color(0xFFF7F3EF),
          appBarTheme: AppBarTheme(
            backgroundColor: background
          ),
          useMaterial3: true
        ),
        home: SplashScreen());
  }
}
