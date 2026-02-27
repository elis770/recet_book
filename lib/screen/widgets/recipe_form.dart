import 'package:flutter/material.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/l10n/app_localizations.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key});

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _creadoraController = TextEditingController();
  final _imagenController = TextEditingController();
  final _areaController = TextEditingController();
  final _detallesController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _creadoraController.dispose();
    _imagenController.dispose();
    _areaController.dispose();
    _detallesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Listado de configuraciones de campos para evitar repetición
    final List<Map<String, dynamic>> fields = [
      {
        'label': l10n.labelName,
        'controller': _nombreController,
        'validator': (String? value) =>
            (value == null || value.isEmpty) ? l10n.errorNameRequired : null,
      },
      {
        'label': l10n.labelCreator,
        'controller': _creadoraController,
        'validator': (String? value) =>
            (value == null || value.isEmpty) ? l10n.errorCreatorRequired : null,
      },
      {
        'label': l10n.labelArea,
        'controller': _areaController,
        'validator': (String? value) => null,
      },
      {
        'label': l10n.labelInstructions,
        'controller': _detallesController,
        'maxLines': 3,
        'validator': (String? value) => (value == null || value.isEmpty)
            ? l10n.errorInstructionsRequired
            : null,
      },
      {
        'label': l10n.labelImageUrl,
        'controller': _imagenController,
        'validator': (String? value) {
          if (value == null || value.isEmpty) return l10n.errorImageRequired;
          final uri = Uri.tryParse(value);
          if (uri == null || !uri.isAbsolute) return l10n.errorInvalidUrl;
          return null;
        },
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  l10n.formTitle,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Bucle que genera dinámicamente cada campo del formulario
              for (var field in fields) ...[
                _buildTextField(
                  label: field['label'],
                  controller: field['controller'],
                  validator: field['validator'],
                  maxLines: field['maxLines'] ?? 1,
                ),
                const SizedBox(height: 16),
              ],

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newRecipe = Recipe(
                        id: DateTime.now().millisecondsSinceEpoch,
                        nombre: _nombreController.text,
                        creadora: _creadoraController.text,
                        imagen: _imagenController.text,
                        area: _areaController.text,
                        detalles: _detallesController.text,
                        isManual: true,
                      );
                      Navigator.pop(context, newRecipe);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    l10n.btnSubmit,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: AppColors.fontFamily,
            color: AppColors.primary,
          ),
          fillColor: AppColors.secondary,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
