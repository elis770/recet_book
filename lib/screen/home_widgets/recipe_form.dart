import 'package:flutter/material.dart';
import 'package:recet_book/models/recipe.dart';
import 'package:recet_book/config/app_colors.dart';

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nombreController = TextEditingController();
    final _creadoraController = TextEditingController();
    final _imagenController = TextEditingController();
    final _areaController = TextEditingController();
    final _detallesController = TextEditingController();

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
                  'Add New Recipe',
                  style: TextStyle(color: AppColors.secondary, fontSize: 20),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Nombre',
                controller: _nombreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Creadora',
                controller: _creadoraController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a creator name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Área (País/Región)',
                controller: _areaController,
                validator: (value) => null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Instrucciones/Detalles',
                controller: _detallesController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructions';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Imagen (url)',
                controller: _imagenController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  final uri = Uri.tryParse(value);
                  if (uri == null || !uri.isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                  child: const Text(
                    'Submit',
                    style: TextStyle(
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
          labelStyle: TextStyle(fontFamily: 'Roboto', color: AppColors.primary),
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
