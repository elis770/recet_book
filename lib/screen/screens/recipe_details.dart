import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/provider/recipe_provider.dart';
import 'package:recet_book/screen/widgets/manual_detail_card.dart';
import 'package:recet_book/screen/widgets/meal_detail_card.dart';
import 'package:recet_book/l10n/app_localizations.dart';

class RecipeDetails extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation =
        Tween<double>(begin: 0.9, end: 1.2).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe.nombre,
          style: const TextStyle(color: AppColors.primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<RecipeProvider>(
            builder: (context, provider, child) {
              final currentRecipe = provider.recipes.firstWhere(
                (r) =>
                    r.id == widget.recipe.id &&
                    r.nombre == widget.recipe.nombre,
                orElse: () => widget.recipe,
              );
              return IconButton(
                icon: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Icon(
                    currentRecipe.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: currentRecipe.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
                onPressed: () {
                  provider.toggleFavorite(currentRecipe);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.recipe.imagen,
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
                    widget.recipe.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.recipeBy(widget.recipe.creadora),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.detailsFromApi,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.recipe.isManual)
                    ManualDetailCard(recipe: widget.recipe)
                  else
                    FutureBuilder<List<dynamic>?>(
                      future: context.read<RecipeProvider>().fetchMealDetails(
                        widget.recipe.nombre,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            AppLocalizations.of(context)!.errorLoadingDetails,
                          );
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Text(
                            AppLocalizations.of(context)!.noDetailsFound,
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
