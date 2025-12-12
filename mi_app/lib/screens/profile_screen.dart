// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  final TextEditingController _nameController = TextEditingController(text: 'John Alban ');
  final TextEditingController _addressController = TextEditingController(text: 'Av. Nueva Aurora 573');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preferencias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Modo oscuro'),
                Switch(
                  value: _darkMode,
                  onChanged: (val) => setState(() => _darkMode = val),
                ),
              ],
            ),
            const Divider(height: 32),
            const Text('Información', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre completo'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Dirección de entrega'),
              // maxLines: 2,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perfil actualizado')),
                  );
                },
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}