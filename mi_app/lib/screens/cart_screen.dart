// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = []; // Lista para almacenar los ítems del carrito

  @override
  void initState() {
    super.initState();
    _loadCartItems(); // Cargar los ítems del carrito al iniciar la pantalla
  }

  // Método para cargar los ítems del carrito desde Supabase
  Future<void> _loadCartItems() async {
    final supabaseClient = supabase.Supabase.instance.client;
    final user = supabaseClient.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión para ver tu carrito')),
      );
      return;
    }

    try {
      final response = await supabaseClient
          .from('cart_items')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      setState(() {
        cartItems = response as List<Map<String, dynamic>>;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar el carrito: $e')),
      );
    }
  }

  // Método para eliminar un ítem del carrito en Supabase
  Future<void> _removeItem(String itemId) async {
    final supabaseClient = supabase.Supabase.instance.client;

    try {
      await supabaseClient.from('cart_items').delete().eq('id', itemId);

      // Actualizar la lista local
      setState(() {
        cartItems.removeWhere((item) => item['id'] == itemId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar el producto: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Tu carrito está vacío'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(item['product_name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tamaño: ${item['size']}'),
                        if (item['extra_cheese']) Text('Queso extra'),
                        if (item['extra_bacon']) Text('Tocino extra'),
                        if (item['extra_beef']) Text('Carne extra'),
                        if (item['notes'] != null && item['notes'].isNotEmpty)
                          Text('Notas: ${item['notes']}'),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () => _removeItem(item['id']), // 👈 Eliminar el ítem
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