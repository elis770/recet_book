class Recipe {
  final int id;
  final String nombre;
  final String creadora;
  final String imagen;
  final bool isManual;
  final String? detalles;
  final String? area;

  Recipe({
    required this.id,
    required this.nombre,
    required this.creadora,
    required this.imagen,
    this.isManual = false,
    this.detalles,
    this.area,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      nombre: json['nombre'],
      creadora: json['creadora'],
      imagen: json['imagen'],
      isManual: json['isManual'] ?? false,
      detalles: json['detalles'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'creadora': creadora,
      'imagen': imagen,
      'isManual': isManual,
      'detalles': detalles,
      'area': area,
    };
  }

  @override
  String toString() {
    return 'Recipe{id: $id, nombre: $nombre, creadora: $creadora, imagen: $imagen, isManual: $isManual, detalles: $detalles, area: $area}';
  }
}
