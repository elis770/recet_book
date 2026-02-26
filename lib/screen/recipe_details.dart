import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/provider/recipe_provider.dart';
import 'package:recet_book/screen/details_widgets/manual_detail_card.dart';
import 'package:recet_book/screen/details_widgets/meal_detail_card.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.nombre,
          style: const TextStyle(color: AppColors.primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                recipe.imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Por: ${recipe.creadora}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Detalles desde TheMealDB',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (recipe.isManual)
                    ManualDetailCard(recipe: recipe)
                  else
                    FutureBuilder<List<dynamic>?>(
                      future: context.read<RecipeProvider>().fetchMealDetails(
                        recipe.nombre,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Error al cargar detalles de la API',
                          );
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Text(
                            'No se encontraron recetas en TheMealDB.',
                          );
                        }

                        final meals = snapshot.data!;
                        return Column(
                          children: meals
                              .map((meal) => MealDetailCard(meal: meal))
                              .toList(),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
