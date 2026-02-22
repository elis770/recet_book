class Recipe {
  final int id;
  final String nombre;
  final String creadora;
  final String imagen;

  Recipe({
    required this.id,
    required this.nombre,
    required this.creadora,
    required this.imagen,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      nombre: json['nombre'],
      creadora: json['creadora'],
      imagen: json['imagen'],
    );
  }
}