// lib/screens/product_detail_screen.dart
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  const ProductDetailScreen({super.key, required this.name});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedSize = 'Mediano';
  bool extraCheese = false;
  bool extraBacon = false;
  bool extraBeef = false;


  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://www.burgerfi.com/wp-content/uploads/2025/03/juicy-burger-png.webp',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Selecciona el tamaño:'),
            const SizedBox(height: 8),
            // Radio buttons
            Row(
              children: ['Pequeño', 'Mediano', 'Grande'].map((size) {
                return Flexible(
                  child: RadioListTile<String>(
                    title: Text(size),
                    value: size,
                    groupValue: selectedSize,
                    onChanged: (val) => setState(() => selectedSize = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Agregados extra:'),            
            CheckboxListTile(
              title: const Text('Tomate extra'),
              value: extraBacon,
              onChanged: (val) => setState(() => extraBacon = val!),
            ),
            CheckboxListTile(
              title: const Text('Queso extra'),
              value: extraCheese,
              onChanged: (val) => setState(() => extraCheese = val!),
            ),
            CheckboxListTile(
              title: const Text('Carne extra'),
              value: extraBeef,
              onChanged: (val) => setState(() => extraBeef = val!),
            ),
            const SizedBox(height: 16),
            const Text('Notas especiales:'),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej: Sin lechuga...',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Agregado al carrito!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Agregar al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}