// 1 este es el punto de entrada de la aplicacion, aqui configuramos la app y definimos que pantalla se muestra al inicio


// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection_container.dart' as di; // Asegúrate de haber copiado injection_container.dart


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await di.initDependencies(); // Inicializa GetIt con el AuthBloc y servicios
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