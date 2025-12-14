// 2. el paso 2

// const se maneja en forma de constante

// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:mi_app/features/auth/presentation/pages/login_page.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../widgets/product_card.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/auth_event.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FastFood App'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const CartScreen())),
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color.fromARGB(255, 0, 26, 255)),
                child: Center(
                    child: Text('Menú',
                        style: TextStyle(fontSize: 24, color: Colors.white))),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Opciones'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen())),
              ),
              // 👇 NUEVO: Cerrar sesión
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(const AuthSignOutRequested());
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Página principal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: List.generate(4, (index) {
                    final prices = [8.99, 11.99, 14.50, 9.99, 12.75, 15.00];
                    double currentPrice = prices[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(name: 'Hamburguesa tipo ${index + 1}')),
                      ),
                      child: ProductCard(price: currentPrice),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Ofertas'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Más'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}