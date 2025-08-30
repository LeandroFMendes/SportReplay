import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sport_replay/screens/home_screen.dart';
import 'package:sport_replay/screens/login_screen.dart';
import 'routes.dart';
import 'theme.dart';
import 'firebase_options.dart'; // gerado pelo FlutterFire CLI
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Replay',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // tema do app
      home: const AuthWrapper(), // decide qual tela o aplicativo vai iniciar, vai depender se o usuário ja fez login anteriormente
      routes: AppRoutes.getRoutes(), // rotas estáticas
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const HomeScreen(); // usuário logado -> vai pra Home
        }
        return const LoginScreen(); // não logado -> vai pro Login
      },
    );
  }
}
