import 'package:flutter/material.dart';
import 'package:recet_book/models/recipe.dart';
import 'base_detail_card.dart';

class ManualDetailCard extends StatelessWidget {
  final Recipe recipe;

  const ManualDetailCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return BaseDetailCard(
      title: recipe.nombre,
      area: recipe.area ?? 'Desconocida',
      instructions: recipe.detalles ?? 'Sin instrucciones.',
    );
  }
}
