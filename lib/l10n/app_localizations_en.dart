// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Argentinian Recipes';

  @override
  String get navInicio => 'Home';

  @override
  String get navFavoritos => 'Favorites';

  @override
  String get noFavoritesFound => 'No favorite recipes yet';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get noRecipesFound => 'No recipes found';

  @override
  String recipeBy(String creator) {
    return 'By: $creator';
  }

  @override
  String get detailsFromApi => 'Details from TheMealDB';

  @override
  String get errorLoadingDetails => 'Error loading details from API';

  @override
  String get noDetailsFound => 'No recipes found on TheMealDB.';

  @override
  String get labelName => 'Name';

  @override
  String get errorNameRequired => 'Please enter a name';

  @override
  String get labelCreator => 'Creator';

  @override
  String get errorCreatorRequired => 'Please enter a creator name';

  @override
  String get labelArea => 'Area (Country/Region)';

  @override
  String get labelInstructions => 'Instructions/Details';

  @override
  String get errorInstructionsRequired => 'Please enter instructions';

  @override
  String get labelImageUrl => 'Image (url)';

  @override
  String get errorImageRequired => 'Please enter an image URL';

  @override
  String get errorInvalidUrl => 'Please enter a valid URL';

  @override
  String get formTitle => 'Add New Recipe';

  @override
  String get btnSubmit => 'Submit';

  @override
  String labelAreaWithTitle(String area) {
    return 'Area: $area';
  }

  @override
  String get labelInstructionsTitle => 'Instructions:';

  @override
  String get noName => 'No name';

  @override
  String get unknown => 'Unknown';

  @override
  String get noInstructions => 'No instructions';
}
