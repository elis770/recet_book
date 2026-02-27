import 'package:flutter/material.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/screen/widgets/recipe_card.dart';
import 'package:recet_book/l10n/app_localizations.dart';

class RecipeListScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final bool isLoading;
  final String? error;

  const RecipeListScreen({
    super.key,
    required this.recipes,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Text(AppLocalizations.of(context)!.errorMessage(error!)),
      );
    }

    if (recipes.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noRecipesFound));
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: recipes[index]);
      },
    );
  }
}
