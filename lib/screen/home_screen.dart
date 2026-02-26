import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/provider/recipe_provider.dart';
import 'package:recet_book/screen/home_widgets/recipe_card.dart';
import 'package:recet_book/screen/home_widgets/recipe_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          if (provider.recipes.isEmpty) {
            return const Center(child: Text('No recipes found'));
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: provider.recipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: provider.recipes[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
        onPressed: () async {
          final newRecipe = await _showBottom(context);
          if (newRecipe != null && mounted) {
            context.read<RecipeProvider>().addRecipe(newRecipe);
          }
        },
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
