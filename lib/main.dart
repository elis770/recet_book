import 'package:flutter/material.dart';
import 'package:recet_book/screen/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recife App',
      home: RecipeBook(),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            'Libro de Recetas',
            style: TextStyle(color: Colors.orange),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.red,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.white,
            tabs: [Tab(icon: Icon(Icons.home), text: 'Home')],
          ),
        ),
        body: const TabBarView(children: [HomeScreen()]),
      ),
    );
  }
}