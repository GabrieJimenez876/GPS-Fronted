
import 'package:flutter/material.dart';

class AgregarLineaPage extends StatefulWidget {
  @override
  _AgregarLineaPageState createState() => _AgregarLineaPageState();
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
      // Aquí se puede enviar la información al backend
      print('Nombre: \$nombre');
      print('Código: \$codigo');
      print('Sindicato: \$sindicato');
      print('Paradas: \$paradas');
      print('Recorrido: \$recorrido');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Línea guardada correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Nueva Línea')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre de la línea'),
                onSaved: (value) => nombre = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el nombre' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Código'),
                onSaved: (value) => codigo = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el código' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sindicato'),
                onSaved: (value) => sindicato = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el sindicato' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recorrido (calles o coordenadas)'),
                onSaved: (value) => recorrido = value ?? '',
                validator: (value) => value!.isEmpty ? 'Ingrese el recorrido' : null,
              ),
              SizedBox(height: 16),
              Text('Paradas:', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: paradaController,
                      decoration: InputDecoration(hintText: 'Nombre de la parada'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: agregarParada,
                  ),
                ],
              ),
              Wrap(
                children: paradas.map((p) => Chip(label: Text(p))).toList(),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: guardarLinea,
                child: Text('Guardar Línea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
