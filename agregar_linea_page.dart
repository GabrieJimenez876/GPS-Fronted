import 'package:flutter/material.dart';

class AgregarLineaPage extends StatefulWidget {
  const AgregarLineaPage({super.key});

  @override
  State<AgregarLineaPage> createState() => _AgregarLineaPageState();
}

class _AgregarLineaPageState extends State<AgregarLineaPage> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String codigo = '';
  String sindicato = '';
  List<String> paradas = [];
  String recorrido = '';

  final paradaController = TextEditingController();

  void agregarParada() {
    if (paradaController.text.isNotEmpty) {
      setState(() {
        paradas.add(paradaController.text);
        paradaController.clear();
      });
    }
  }

  void guardarLinea() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Nombre: $nombre');
      print('Código: $codigo');
      print('Sindicato: $sindicato');
      print('Paradas: $paradas');
      print('Recorrido: $recorrido');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Línea guardada correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Nueva Línea')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre de la línea'),
                onSaved: (value) => nombre = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el nombre' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Código'),
                onSaved: (value) => codigo = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el código' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sindicato'),
                onSaved: (value) => sindicato = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el sindicato' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recorrido (calles o coordenadas)'),
                onSaved: (value) => recorrido = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el recorrido' : null,
              ),
              const SizedBox(height: 16),
              const Text('Paradas:', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: paradaController,
                      decoration: const InputDecoration(hintText: 'Nombre de la parada'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: agregarParada,
                  ),
                ],
              ),
              Wrap(
                children: paradas.map((p) => Chip(label: Text(p))).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: guardarLinea,
                child: const Text('Guardar Línea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
