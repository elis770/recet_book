import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/provider/recipe_provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/screen/screens/main_screen.dart';

import 'package:recet_book/l10n/app_localizations.dart';

import 'package:recet_book/provider/locale_provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recife App',
      theme: ThemeData(fontFamily: AppColors.fontFamily),
      locale: localeProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainScreen(),
    );
  }
}
