import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarLineaPage extends StatefulWidget {
  const AgregarLineaPage({super.key});

  @override
  State<AgregarLineaPage> createState() => _AgregarLineaPageState();
}

class _AgregarLineaPageState extends State<AgregarLineaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _geojsonController = TextEditingController();

  bool _isLoading = false;
  String _message = '';
  Color _messageColor = Colors.transparent;

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _geojsonController.dispose();
    super.dispose();
  }

  void _showMessage(String message, Color color) {
    setState(() {
      _message = message;
      _messageColor = color;
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:4001/routes/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'colorHex': _colorController.text,
          'geojsonGeometry': _geojsonController.text,
        }),
      );

      if (response.statusCode == 201) {
        _showMessage('✅ ¡Ruta agregada exitosamente!', Colors.green);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        _showMessage(
          'Error al agregar la ruta: ${responseBody['error'] ?? 'Error desconocido'}',
          Colors.orange,
        );
      }
    } catch (e) {
      _showMessage('Error de conexión: $e', Colors.red);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Línea'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Agregar Nueva Línea de Transporte',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC38DDC),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la Línea',
                    hintText: 'Ej: Línea 1 - Norte Sur',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el nombre de la línea';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(
                    labelText: 'Color (Hex)',
                    hintText: 'Ej: #FF0000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el color en formato hex';
                    }
                    if (!RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(value)) {
                      return 'Ingrese un color hex válido (ej: #FF0000)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _geojsonController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'GeoJSON de la Ruta',
                    hintText: '{"type": "LineString", "coordinates": [[...]]}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el GeoJSON de la ruta';
                    }
                    try {
                      final decoded = jsonDecode(value);
                      if (decoded['type'] != 'LineString') {
                        return 'El GeoJSON debe ser de tipo LineString';
                      }
                      return null;
                    } catch (e) {
                      return 'GeoJSON inválido';
                    }
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC38DDC),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          'Guardar Ruta',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                // Contenedor del mensaje de estado (Error/Éxito)
                if (_message.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _messageColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _messageColor, width: 2),
                    ),
                    child: Text(
                      _message,
                      style: TextStyle(color: _messageColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
