class Recipe {
  final int id;
  final String nombre;
  final String creadora;
  final String imagen;
  final bool isManual;
  final String? detalles;
  final String? area;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.nombre,
    required this.creadora,
    required this.imagen,
    this.isManual = false,
    this.detalles,
    this.area,
    this.isFavorite = false,
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
      isFavorite: json['isFavorite'] ?? false,
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
      'isFavorite': isFavorite,
    };
  }

  Recipe copyWith({
    int? id,
    String? nombre,
    String? creadora,
    String? imagen,
    bool? isManual,
    String? detalles,
    String? area,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      creadora: creadora ?? this.creadora,
      imagen: imagen ?? this.imagen,
      isManual: isManual ?? this.isManual,
      detalles: detalles ?? this.detalles,
      area: area ?? this.area,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return 'Recipe{id: $id, nombre: $nombre, creadora: $creadora, imagen: $imagen, isManual: $isManual, detalles: $detalles, area: $area, isFavorite: $isFavorite}';
  }
}
