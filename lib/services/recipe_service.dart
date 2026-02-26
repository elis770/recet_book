import 'package:recet_book/services/http_service.dart';
import 'package:recet_book/models/recipe.dart';

abstract class MealBaseService<T> {
  final HttpService _httpService = HttpService();

  /// URL que será definida por cada clase hija mediante override.
  String get url;

  /// Método principal que ejecuta la petición HTTP y procesa la lista.
  Future<List<T>> execute() async {
    try {
      final result = await _httpService.get(url);

      if (result['success']) {
        final data = result['data'] as Map<String, dynamic>;
        final meals = data['meals'] as List? ?? [];

        return meals.map((meal) => transform(meal)).cast<T>().toList();
      } else {
        throw Exception('Error: ${result['error']}');
      }
    } catch (e) {
      throw Exception('Error al cargar datos: $e');
    }
  }

  /// Método que debe sobrescribir el hijo para decidir cómo se mapea cada item.
  T transform(dynamic meal);
}

/// Child 1: Servicio para obtener recetas argentinas.
/// Sobrescribe la URL y el proceso de mapeo a clase Recipe.
class ArgentinianRecipeService extends MealBaseService<Recipe> {
  @override
  String get url =>
      'https://www.themealdb.com/api/json/v1/1/filter.php?a=argentinian';

  @override
  Recipe transform(dynamic meal) {
    return Recipe(
      id: int.parse(meal['idMeal'] ?? '0'),
      nombre: meal['strMeal'] ?? 'Sin nombre',
      creadora: 'TheMealDB',
      imagen: meal['strMealThumb'] ?? '',
      isManual: false,
    );
  }
}

/// Child 2: Servicio para obtener detalles de comida por nombre.
/// Sobrescribe la URL y devuelve los items de forma dinámica.
class MealDetailService extends MealBaseService<dynamic> {
  final String name;

  MealDetailService(this.name);

  @override
  String get url =>
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$name';

  @override
  dynamic transform(dynamic meal) {
    return meal;
  }
}