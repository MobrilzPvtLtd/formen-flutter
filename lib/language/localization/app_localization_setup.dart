// ignore_for_file: depend_on_referenced_packages

import 'package:dating/language/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizationSetup{
  static const Iterable<Locale> supportedLanguage =[
    Locale('en'),
    Locale('ar'),
    Locale('af'),
    Locale('be'),
    Locale('gu'),
    Locale('hi'),
    Locale('in'),
    Locale('sp'),
    Locale('pt-br'),
  ];

  static  Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =[
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static Locale localeResolutionCallback(Locale? locale,Iterable<Locale> supportedLocales ){
    for(Locale supportedLocal in supportedLanguage){
      if(supportedLocal.languageCode == locale!.languageCode && supportedLocal.countryCode == locale.countryCode){
        return supportedLocal;
      }
    }
    return supportedLanguage.first;
  }
}
