// 1 este es el punto de entrada de la aplicacion, aqui configuramos la app y definimos que pantalla se muestra al inicio


// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastFood App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 253, 237, 5)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}