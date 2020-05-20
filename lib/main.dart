import 'package:flutter/material.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/ui/views/pokemon_list.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        canvasColor: Color(0xFF6649b7),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return PokemonListScreen();
  }
}
