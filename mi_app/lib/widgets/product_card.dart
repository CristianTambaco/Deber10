// lib/widgets/product_card.dart
import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  final double price;

  const ProductCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 250, 236, 42),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fastfood, size: 48, color: const Color.fromARGB(255, 255, 145, 0)),
              const SizedBox(height: 8),
              const Text('        Orden de compra de       ', style: TextStyle(fontWeight: FontWeight.bold)),
              // muestra el precio dinámico
              Text(
                '\$$price',
                style: const TextStyle(color: Colors.green, fontSize: 16),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 224, 201),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('🍔🥤', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}