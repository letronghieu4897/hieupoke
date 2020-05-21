import 'package:device_preview/device_preview.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/ui/views/pokemon_list.dart';
import 'package:uichallenge/ui/views/splash.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'vi_VN',
      supportedLocales: [
        'en_US',
        'vi_VN',
      ]);

  setupServiceLocator();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => LocalizedApp(delegate, MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.bungeeTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen.navigate(
        name: 'intro.flr',
        next: (context) => MyHomePage(),
        until: () => Future.delayed(Duration(seconds: 5)),
        startAnimation: '1',
      ),
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
