import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                width: 125,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(color: Colors.amber,),
                ),
              ),
              SizedBox(width: 26),
              Column(
                children: <Widget>[
                  Text('Tortilla de Patatas'),
                  Text('manuela castañera'),
                  Container(width: 100, height: 25, color: Colors.purple),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}