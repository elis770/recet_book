import 'package:recet_book/services/http_service.dart';
import 'package:recet_book/models/recipe.dart';

class RecipeService {
  final HttpService _httpService = HttpService();

  /// Obtener recetas argentinas de TheMealDB
  /// API: https://www.themealdb.com/api/json/v1/1/filter.php?a=argentinian
  Future<List<Recipe>> getArgentinianRecipes() async {
    try {
      final result = await _httpService.get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?a=argentinian',
      );

      if (result['success']) {
        final data = result['data'] as Map<String, dynamic>;
        final meals = data['meals'] as List;
        
        return meals.map((meal) {
          return Recipe(
            id: int.parse(meal['idMeal'] ?? '0'),
            nombre: meal['strMeal'] ?? 'Sin nombre',
            creadora: 'TheMealDB',
            imagen: meal['strMealThumb'] ?? '',
          );
        }).toList();
      } else {
        throw Exception('Error: ${result['error']}');
      }
    } catch (e) {
      throw Exception('Error al cargar recetas: $e');
    }
  }
}

// Main temporal para pruebas
// void main() async {
//   final recipeService = RecipeService();
  
//   try {
//     final recipes = await recipeService.getArgentinianRecipes();
//     print('✅ Recetas obtenidas: ${recipes.length}');
//     for (var recipe in recipes) {
//       print('- ${recipe.nombre}');
//     }
//   } catch (e) {
//     print('❌ Error: $e');
//   }
// }

  // /// Obtener recetas por categoría
  // /// [category] - La categoría (ej: 'Seafood', 'Vegetarian', etc.)
  // Future<List<Recipe>> getRecipesByCategory(String category) async {
  //   try {
  //     final result = await _httpService.get(
  //       'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
  //     );

  //     if (result['success']) {
  //       final data = result['data'] as Map<String, dynamic>;
  //       final meals = data['meals'] as List;
        
  //       return meals.map((meal) {
  //         return Recipe(
  //           id: meal['idMeal'] ?? '',
  //           nombre: meal['strMeal'] ?? 'Sin nombre',
  //           creadora: 'TheMealDB',
  //           imagen: meal['strMealThumb'] ?? '',
  //         );
  //       }).toList();
  //     } else {
  //       throw Exception('Error: ${result['error']}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al cargar recetas: $e');
  //   }
  // }

  // /// Obtener recetas por área/país
  // /// [area] - El área/país (ej: 'Italian', 'Mexican', 'American', etc.)
  // Future<List<Recipe>> getRecipesByArea(String area) async {
  //   try {
  //     final result = await _httpService.get(
  //       'https://www.themealdb.com/api/json/v1/1/filter.php?a=$area',
  //     );

  //     if (result['success']) {
  //       final data = result['data'] as Map<String, dynamic>;
  //       final meals = data['meals'] as List;
        
  //       return meals.map((meal) {
  //         return Recipe(
  //           id: meal['idMeal'] ?? '',
  //           nombre: meal['strMeal'] ?? 'Sin nombre',
  //           creadora: 'TheMealDB',
  //           imagen: meal['strMealThumb'] ?? '',
  //         );
  //       }).toList();
  //     } else {
  //       throw Exception('Error: ${result['error']}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al cargar recetas: $e');
  //   }
  // }