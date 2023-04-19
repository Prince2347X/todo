import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:todo/screens/home.dart';
import 'package:todo/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: appTheme,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(
            0xFFEEEEEE,
          ),
          fontFamily: 'Poppins',
        ),
        home: const HomeScreen(),
      ),
    ),
  );
}

MaterialColor appTheme = const MaterialColor(
  0xFFFAB085,
  <int, Color>{
    50: Color.fromRGBO(250, 168, 133, 0.1),
    100: Color.fromRGBO(250, 168, 133, 0.2),
    200: Color.fromRGBO(250, 168, 133, 0.3),
    300: Color.fromRGBO(250, 168, 133, 0.4),
    400: Color.fromRGBO(250, 168, 133, 0.5),
    500: Color.fromRGBO(250, 168, 133, 0.6),
    600: Color.fromRGBO(250, 168, 133, 0.7),
    700: Color.fromRGBO(250, 168, 133, 0.8),
    800: Color.fromRGBO(250, 168, 133, 0.9),
    900: Color.fromRGBO(250, 168, 133, 1.0),
  },
);
