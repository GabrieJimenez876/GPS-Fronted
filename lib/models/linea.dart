class Linea {
  final String nombre;
  final String codigo;
  final String sindicato;
  final List<String> paradas;

  Linea({
    required this.nombre,
    required this.codigo,
    required this.sindicato,
    required this.paradas,
  });

  factory Linea.fromJson(Map<String, dynamic> json) {
    return Linea(
      nombre: json['nombre'] ?? '',
      codigo: json['codigo'] ?? '',
      sindicato: json['sindicato'] ?? '',
      paradas: List<String>.from(json['paradas'] ?? []),
    );
  }
}
