import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';
import 'theme.dart';
import 'firebase_options.dart'; // gerado pelo FlutterFire CLI

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
      initialRoute: '/login', // inicia na tela de login
      routes: AppRoutes.getRoutes(), // rotas estáticas
    );
  }
}
