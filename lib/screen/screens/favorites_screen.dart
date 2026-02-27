import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/provider/recipe_provider.dart';
import 'package:recet_book/screen/screens/recipe_list_screen.dart';
import 'package:recet_book/l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          final favoriteRecipes = provider.favoriteRecipes;

          if (!provider.isLoading && favoriteRecipes.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noFavoritesFound),
            );
          }

          return RecipeListScreen(
            recipes: favoriteRecipes,
            isLoading: provider.isLoading,
            error: provider.error,
          );
        },
      ),
    );
  }
}
