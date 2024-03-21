import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:getx_project/languages/khmer_cupertino_localization_delegate.dart';
import 'package:getx_project/src/service/localization_service.dart';

import 'src/screens/home/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    LocalizationService().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalizationService(),
      fallbackLocale: LocalizationService.fallbackLocale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        KhmerCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('km'),
      ],
      home: const MyHomePage(),
    );
  }
}