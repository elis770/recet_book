import 'package:flutter/material.dart';
import 'base_detail_card.dart';
import 'package:recet_book/l10n/app_localizations.dart';

class MealDetailCard extends StatelessWidget {
  final Map<String, dynamic> meal;

  const MealDetailCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return BaseDetailCard(
      title: meal['strMeal'] ?? AppLocalizations.of(context)!.noName,
      area: meal['strArea'] ?? AppLocalizations.of(context)!.unknown,
      instructions:
          meal['strInstructions'] ??
          AppLocalizations.of(context)!.noInstructions,
    );
  }
}
