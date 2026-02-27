import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/provider/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageButton(
            label: 'ES',
            isActive: currentLocale.languageCode == 'es',
            onTap: () =>
                context.read<LocaleProvider>().setLocale(const Locale('es')),
          ),
          const VerticalDivider(width: 16, color: AppColors.primary),
          _LanguageButton(
            label: 'EN',
            isActive: currentLocale.languageCode == 'en',
            onTap: () =>
                context.read<LocaleProvider>().setLocale(const Locale('en')),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.primary : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
