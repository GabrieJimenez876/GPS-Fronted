import 'package:flutter/material.dart';

class AgregarLineaPage extends StatefulWidget {
  const AgregarLineaPage({super.key});

  @override
  State<AgregarLineaPage> createState() => _AgregarLineaPageState();
}

class _AgregarLineaPageState extends State<AgregarLineaPage> {
  final _nombreController = TextEditingController();
  final _codigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Línea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(labelText: 'Código'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _codigoController.dispose();
    super.dispose();
  }
}
