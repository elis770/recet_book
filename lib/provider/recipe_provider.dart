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

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ejecutamos el servicio heredado
      final apiRecipes = await _argentinianService.execute();
      _recipes = apiRecipes;
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
}
