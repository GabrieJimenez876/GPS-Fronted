import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia en web

class AgregarLineaPage extends StatefulWidget {
  const AgregarLineaPage({super.key});

  @override
  State<AgregarLineaPage> createState() => _AgregarLineaPageState();
}

class _AgregarLineaPageState extends State<AgregarLineaPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  Future<void> guardarLinea() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> lineas = prefs.getStringList('lineas') ?? [];
    lineas.add('${nombreController.text}:${descripcionController.text}');
    await prefs.setStringList('lineas', lineas);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Línea agregada')),
    );
    Navigator.pop(context); // Vuelve al mapa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Línea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre de la Línea'),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardarLinea,
              child: const Text('Guardar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'), // Vuelve al mapa
              child: const Text('Volver al Mapa'),
            ),
          ],
        ),
      ),
    );
  }
}
