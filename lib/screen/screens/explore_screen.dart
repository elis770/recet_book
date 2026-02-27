import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/provider/recipe_provider.dart';
import 'package:recet_book/screen/widgets/recipe_form.dart';
import 'package:recet_book/screen/screens/recipe_list_screen.dart';
import 'package:recet_book/provider/locale_provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<RecipeProvider>();
      if (provider.recipes.isEmpty) {
        provider.fetchRecipes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          return RecipeListScreen(
            recipes: provider.recipes,
            isLoading: provider.isLoading,
            error: provider.error,
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'langTag',
            mini: true,
            backgroundColor: AppColors.secondary,
            child: Text(
              Localizations.localeOf(context).languageCode.toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              context.read<LocaleProvider>().toggleLocale();
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'addTag',
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: AppColors.white),
            onPressed: () async {
              final newRecipe = await _showBottom(context);
              if (newRecipe != null && mounted) {
                context.read<RecipeProvider>().addRecipe(newRecipe);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<Recipe?> _showBottom(BuildContext context) {
    return showModalBottomSheet<Recipe>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        color: AppColors.primary,
        child: const RecipeForm(),
      ),
    );
  }
}
