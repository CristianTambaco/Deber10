// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Lista que sí se puede modificar
  List<String> cartItems = List.generate(3, (i) => 'Hamburguesa tipo ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Tu carrito está vacío'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(cartItems[index]),
                    trailing: TextButton(
                      onPressed: () {
                        setState(() {
                          cartItems.removeAt(index); // 👈 Eliminar producto
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Producto eliminado')),
                        );
                      },
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('¡Pedido realizado!')),
            );
          },
          child: const Text('Confirmar pedido', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
