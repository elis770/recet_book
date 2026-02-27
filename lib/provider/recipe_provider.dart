import 'package:flutter/material.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier {
  // Instancia del servicio específico para recetas argentinas
  final ArgentinianRecipeService _argentinianService =
      ArgentinianRecipeService();

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _error;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Recipe> get favoriteRecipes =>
      _recipes.where((r) => r.isFavorite).toList();

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ejecutamos el servicio heredado
      final apiRecipes = await _argentinianService.execute();

      // Guardamos las recetas manuales actuales para no perderlas
      final manualRecipes = _recipes.where((r) => r.isManual).toList();

      // Preservamos los favoritos locales si la receta ya existía
      final updatedApiRecipes = apiRecipes.map((newRecipe) {
        final existing = _recipes.firstWhere(
          (r) => r.id == newRecipe.id && r.nombre == newRecipe.nombre,
          orElse: () => newRecipe,
        );
        return newRecipe.copyWith(isFavorite: existing.isFavorite);
      }).toList();

      // Combinamos manuales (al principio) con las de la API
      _recipes = [...manualRecipes, ...updatedApiRecipes];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<dynamic>?> fetchMealDetails(String name) async {
    // Para detalles, instanciamos el servicio de búsqueda
    return await MealDetailService(name).execute();
  }

  void addRecipe(Recipe recipe) {
    _recipes.insert(0, recipe);
    notifyListeners();
  }

  void toggleFavorite(Recipe recipe) {
    final index = _recipes.indexWhere(
      (r) => r.id == recipe.id && r.nombre == recipe.nombre,
    );
    if (index != -1) {
      _recipes[index] = _recipes[index].copyWith(
        isFavorite: !_recipes[index].isFavorite,
      );
      notifyListeners();
    }
  }
}
