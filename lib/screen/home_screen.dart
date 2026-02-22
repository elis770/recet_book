import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/config/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//useEffect = ciclo de vida del componente
class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _recipes;

  @override
  void initState() {
    super.initState();
    _recipes = _loadRecipes();
  }

  Future<List<Recipe>> _loadRecipes() async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString('recipes.json');
    final jsonData = json.decode(jsonString) as List;
    return jsonData.map((item) => Recipe.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: FutureBuilder<List<Recipe>>(
        future: _recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          }

          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return _RecipesCard(context, recipes[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _RecipesCard(BuildContext context, Recipe recipe) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 125,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 125,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                recipe.imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(width: 26),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipe.nombre,
                    style: const TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(width: 100, height: 2, color: AppColors.secondary),
                  Text(
                    recipe.creadora,
                    style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}