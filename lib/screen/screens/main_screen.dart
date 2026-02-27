import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recet_book/config/app_colors.dart';
import 'package:recet_book/l10n/app_localizations.dart';
import 'package:recet_book/provider/locale_provider.dart';
import 'package:recet_book/screen/screens/explore_screen.dart';
import 'package:recet_book/screen/screens/favorites_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: Text(
            AppLocalizations.of(context)!.appTitle,
            style: const TextStyle(color: AppColors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                height: 35,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => context.read<LocaleProvider>().setLocale(
                            const Locale('es'),
                          ),
                          child: Text(
                            'ES',
                            style: TextStyle(
                              color:
                                  Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'es'
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 16, color: Colors.grey),
                        GestureDetector(
                          onTap: () => context.read<LocaleProvider>().setLocale(
                            const Locale('en'),
                          ),
                          child: Text(
                            'EN',
                            style: TextStyle(
                              color:
                                  Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'en'
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: AppColors.secondary,
            labelColor: AppColors.secondary,
            unselectedLabelColor: AppColors.white,
            tabs: [
              Tab(
                icon: const Icon(Icons.home),
                text: AppLocalizations.of(context)!.navInicio,
              ),
              Tab(
                icon: const Icon(Icons.favorite),
                text: AppLocalizations.of(context)!.navFavoritos,
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [ExploreScreen(), FavoritesScreen()]),
      ),
    );
  }
}
