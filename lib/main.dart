import 'package:agripure_mobile/presentation/screens/auth_screen.dart';
import 'package:agripure_mobile/presentation/screens/home_screen.dart';
import 'package:agripure_mobile/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedToken = prefs.getString('token');
  runApp(MyApp(storedToken: storedToken));
}

class MyApp extends StatelessWidget {
  final String? storedToken;
  const MyApp({super.key, this.storedToken});

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget initialScreen = const AuthScreen();
    if (storedToken != null) {
      bool isTokenExpired = JwtDecoder.isExpired(storedToken!);

      if (!isTokenExpired) {
        initialScreen = const HomeScreen(index: 0);
      } else {
        initialScreen = const AuthScreen();
      }
    } else {
      initialScreen = const AuthScreen();
    }

    return MaterialApp(
      title: 'AgriPure App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      //home: initialScreen,
      initialRoute: '/splash',
      routes: {
        '/': (context) => initialScreen,
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(index: 0),
        '/auth': (context) => const AuthScreen()
      },
    );
  }
}