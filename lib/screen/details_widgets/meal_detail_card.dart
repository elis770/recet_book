import 'package:flutter/material.dart';
import 'base_detail_card.dart';

class MealDetailCard extends StatelessWidget {
  final Map<String, dynamic> meal;

  const MealDetailCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return BaseDetailCard(
      title: meal['strMeal'] ?? 'Sin nombre',
      area: meal['strArea'] ?? 'Desconocida',
      instructions: meal['strInstructions'] ?? 'Sin instrucciones',
    );
  }
}
