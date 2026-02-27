// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Recetas Argentinas';

  @override
  String get navInicio => 'Inicio';

  @override
  String get navFavoritos => 'Favoritos';

  @override
  String get noFavoritesFound => 'No tienes recetas favoritas aún';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get noRecipesFound => 'No se encontraron recetas';

  @override
  String recipeBy(String creator) {
    return 'Por: $creator';
  }

  @override
  String get detailsFromApi => 'Detalles desde TheMealDB';

  @override
  String get errorLoadingDetails => 'Error al cargar detalles de la API';

  @override
  String get noDetailsFound => 'No se encontraron recetas en TheMealDB.';

  @override
  String get labelName => 'Nombre';

  @override
  String get errorNameRequired => 'Por favor ingresa un nombre';

  @override
  String get labelCreator => 'Creadora';

  @override
  String get errorCreatorRequired =>
      'Por favor ingresa el nombre de la creadora';

  @override
  String get labelArea => 'Área (País/Región)';

  @override
  String get labelInstructions => 'Instrucciones/Detalles';

  @override
  String get errorInstructionsRequired => 'Por favor ingresa las instrucciones';

  @override
  String get labelImageUrl => 'Imagen (url)';

  @override
  String get errorImageRequired => 'Por favor ingresa una URL de imagen';

  @override
  String get errorInvalidUrl => 'Por favor ingresa una URL válida';

  @override
  String get formTitle => 'Añadir Nueva Receta';

  @override
  String get btnSubmit => 'Enviar';

  @override
  String labelAreaWithTitle(String area) {
    return 'Área: $area';
  }

  @override
  String get labelInstructionsTitle => 'Instrucciones:';

  @override
  String get noName => 'Sin nombre';

  @override
  String get unknown => 'Desconocida';

  @override
  String get noInstructions => 'Sin instrucciones';
}
